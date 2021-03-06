require "ccfeeder/version" unless __FILE__ == $0

require 'rest-client'
require 'crack'
require 'yaml'
require 'chronic'
require 'json'
require 'openssl'
require 'logger'

module CcFeeder

  YAML::ENGINE.yamler = 'syck'

  class CacheCow

    CACHE_TIME = 4
    RETRY_INTERVAL = 10
    MAX_RETRIES = 3 #0 * 24 * 60 * 60 / RETRY_INTERVAL # retry for 30 days max.

    attr_reader :crops_cache, :crops_time,
                :crops_by_crop_number_cache,
                :subscribers_cache, :subscribers_time,
                :subscriptions_cache, :subscriptions_time

    def initialize(args)


      @debug = args.fetch(:debug) { false }
      @log = args.fetch(:logger) { Logger.new(STDOUT) }

      @secret_key = args.fetch(:secret_key) { "" }

      @url = args.fetch(:url) { raise "You must provide :url" }

      @username = args.fetch(:username) { "" }
      @password = args.fetch(:password) { "" }

      @max_retries = args.fetch(:max_retries) { MAX_RETRIES }
      @retry_interval = args.fetch(:retry_interval) { RETRY_INTERVAL }
      @cache_time = args.fetch(:cache_time) { CACHE_TIME }

      @resource = RestClient::Resource.new @url

      @crops_time = Time.now
      @subscribers_time = Time.now
      @subscriptions_time = Time.now

      @crops_by_crop_number_cache = Hash.new

      @connected = false
      @retries = 0

      while !@connected && (@retries < @max_retries)
        @retries += 1
        begin
          # Try and load the crops to make sure we have a connection
          #          YAML::ENGINE.yamler = 'syck'
          Crack::JSON.parse(@resource["crops.json"].get)
          @connected = true
        rescue
          @log.fatal "(#{@retries}/#{@max_retries}) Unable to obtain connection to #{@url}/crops.json"
          sleep 2
        end
      end

      load_crops
      load_subscribers
      load_subscriptions

    end

    def load_crops
      begin
#        YAML::ENGINE.yamler = 'syck'
        crops = Crack::JSON.parse(@resource["crops.json"].get)

        @log.debug "Getting #{@url}/crops.json"

        @crops_cache = Hash.new

        crops.each do |crop|
          @crops_cache[crop["id"]] = crop
          @crops_by_crop_number_cache[crop['crop_number']] = crop
        end

        @crops_time = Time.now

      rescue
        @log.warn "Unable to get crops.json, using cached copy"
      end

    end

    def load_subscribers
      begin
#        YAML::ENGINE.yamler = 'syck'
        subscribers = Crack::JSON.parse(@resource["subscribers.json"].get)

        @log.debug "Getting #{@url}/subscribers.json"

        @subscribers_cache = Hash.new

        subscribers.each do |subscriber|
          @subscribers_cache[subscriber['id']] = subscriber
        end

        @subscribers_time = Time.now

      rescue
        @log.warn "Unable to get subscribers.json, using cached copy"
      end
    end

    def load_subscriptions
      begin
#        YAML::ENGINE.yamler = 'syck'
        subscriptions = Crack::JSON.parse(@resource["subscriptions.json"].get)

        @log.debug "Getting #{@url}/subscriptions.json"

        @subscriptions_cache = Hash.new

        self.crops if @crops_cache.empty?
        self.subscribers if @subscribers_cache.empty?

        subscriptions.each do |subscription|
          subscription['crop'] = @crops_cache[subscription['crop_id']]
          subscription['subscriber'] = @subscribers_cache[subscription['subscriber_id']]
          @subscriptions_cache[subscription['id']] = subscription
        end

        @subscriptions_time = Time.now

      rescue
        @log.warn "Unable to get subscriptions.json, using cached copy"
      end

    end

    def crops_by_crop_number

      if (@crops_time + CACHE_TIME) > Time.now
        @log.debug "Using cached #{@url}/crops.json"
        return @crops_by_crop_number_cache
      end

      load_crops
      return @crops_by_crop_number_cache

    end

    def crops

      if (@crops_time + CACHE_TIME) > Time.now
        @log.debug "Using cached #{@url}/crops.json"
        return @crops_cache
      end

      load_crops
      return @crops_cache

    end

    def subscribers

      if (@subscribers_time + CACHE_TIME) > Time.now
        @log.debug "Using cached #{@url}/subscribers.json"
        return @subscribers_cache
      end

      load_subscribers
      return @subscribers_cache

    end

    def subscriptions

      if (@subscriptions_time + CACHE_TIME) > Time.now
        @log.debug "Using cached #{@url}/subscriptions.json"
        return @subscriptions_cache
      end

      load_subscriptions
      return @subscriptions_cache

    end

    def subscribed?(subscriber_id, crop_number)

      @subscriptions_cache.each do |id, subscription|
        puts "subscriber_id: #{id}"

        if subscription["subscriber_id"] == subscriber_id && subscription["crop"]["crop_number"] == crop_number
          return true
        end
      end
      return false

    end

    # a "change" is detected by the harvester
    def push_change(queued_at, harvester_uuid, change_uuid, crop_number, primary_key, transaction_type, value, old_value)

      data = Hash.new

      data['harvester_uuid'] = harvester_uuid
      data['crop_number'] = crop_number
      data['queue_time'] = queued_at
      data['primary_key'] = primary_key

      begin
#        YAML::ENGINE.yamler = 'syck'
        data['previous_value'] = old_value
      rescue Exception => e
        data['previous_value'] = ""
      end

      begin
#        YAML::ENGINE.yamler = 'syck'
        data['current_value'] = value
      rescue Exception => e
        data['current_value'] = ""
      end

      data['uuid'] = change_uuid
      data['transaction_type'] = transaction_type

      change = Hash.new
      change["change"] = data

      return deliver("changes", change)

    end

    # a "transaction" is sent to a subscriber by the farmer based on the "change"
    def push_transaction(subscription_id, queued_at, change_uuid, transaction_uuid, crop_number, primary_key, transaction_type, value, old_value)

      data = Hash.new

      data['queue_time'] = queued_at
      data['change_uuid'] = change_uuid
      data['uuid'] = transaction_uuid

      transaction = Hash.new
      transaction["transaction"] = data

      return deliver("transactions", transaction)

    end

    def push_delivery_status(queued_at, delivery_uuid, transaction_uuid, endpoint_response_code, endpoint_response_header, endpoint_response_data, endpoint_response_date)

      data = Hash.new

      data['queue_time'] = queued_at
      data['uuid'] = delivery_uuid
      data['transaction_uuid'] = transaction_uuid
      data['endpoint_response_code'] = endpoint_response_code
      data['endpoint_response_header'] = endpoint_response_header
      data['endpoint_response_data'] = endpoint_response_data
      data['endpoint_response_date'] = endpoint_response_date

      delivery = Hash.new
      delivery["delivery"] = data

      return deliver("deliveries", delivery)

    end

    def push_harvester_stats(harvester_uuid, crop_number, began_at, ended_at, total_records, number_of_changes, number_of_adds, number_of_deletes)

      data = Hash.new

      data['uuid'] = harvester_uuid
      data['crop_number'] = crop_number
      data['began_at'] = began_at
      data['ended_at'] = ended_at
      data['total_records'] = total_records
      data['number_of_changes'] = number_of_changes
      data['number_of_adds'] = number_of_adds
      data['number_of_deletes'] = number_of_deletes

      harvest = Hash.new
      harvest["harvest"] = data

      return deliver("harvests", harvest)

    end

#    private

    def calc(secret_key, payload)

      digest = OpenSSL::Digest::Digest.new('sha1')

      sig = OpenSSL::HMAC.hexdigest(digest, secret_key, payload)

      return sig

    end

    def deliver(path, data)

      raw_deliver "#{@url}/#{path}", data

    end


    def raw_deliver(path, data)

      payload = data.to_json

      @delivered = false
      @retries = 0

      result = {:code => 0, :headers => String.new, :body => String.new}

      while !@delivered && (@retries < @max_retries)
        @retries += 1
        begin

          end_point = RestClient::Resource.new path

          sig = calc @secret_key, payload

          headers_to_send = {:content_type => :json, :accept => :json}
          headers_to_send["X_HUB_SIGNATURE"] = sig unless @secret_key.empty?
          response = end_point.post payload, headers_to_send

          puts headers_to_send.inspect

          if (200..201) === response.code
            @delivered = true
            @log.info "Payload delivered to #{path} #{response.code}"

            result[:code] = response.code
            result[:headers] = response.headers
            result[:body] = response.body

            return result
          else
            @log.warn "#{response.code}"

            @log.warn "Retrying #{@retries}/#{@max_retries} in  #{@retry_interval} seconds..."

            sleep RETRY_INTERVAL
          end
        rescue Exception => e
          @log.fatal "ERROR: #{e}"

          @log.fatal "Retrying #{@retries}/#{@max_retries} in  #{@retry_interval} seconds..."
        end

      end # while

      return result

    end
  end

end


if __FILE__ == $0

  require 'uuid'

  u = UUID.new
  crop_number=400

  #cc = CcFeeder::CacheCowLoader.from_environment

  cc = CcFeeder::CacheCow.new :url => "http://localhost:3000"

#  crop_id = cc.crops_by_crop_number[crop_number]["id"]

  cc.subscriptions.each do |subscription_id, subscription|

    unless subscription["active"] == true
      puts("#{self.name} Subscription #{subscription_id} is not active.")
      next
    end

    if cc.crops[subscription["crop_id"]]["crop_number"] == crop_number

      puts "subscribed #{subscription["subscriber_id"]} crop #{crop_number}"

    else
      puts("# #{cc.subscribers[subscription["subscriber_id"]]["name"]} is subscribed to #{cc.crops_by_crop_number[crop_number]["name"]}")
    end
  end

  exit
#cc.crops_by_crop_number.each do |crop_number, crop|
#  puts "#{crop["crop_number"]} #{crop["name"]}"
#end
#
#cc.crops.each do |id, crop|
#  puts "#{crop["id"]} #{crop["name"]}"
#end


#cc = CcFeeder::CacheCow.new :url => "http://cachecow.dev"

#  cc = CacheCow.new(:url => config["url"], :username => config["username"], :password => config["password"])
#  cc = CacheCow.new(:url => "http://cachecow.dev", :username => "", :password => "")

#@crops = Hash.new
#@crops_time = Time.now
#
#@subscribers = Hash.new
#@subscribers_time = Time.now
#
#@subscriptions = Hash.new
#@subscriptions_time = Time.now

#10.times.each do |i|
#  cc.crops.each do |id, value|
#    puts "#{id} #{value["name"]}"
#  end
#  puts "sleeping..." ; sleep 5
#end


#puts "Crops:"
#puts "------------------------------"
#crops = cc.crops
#crops.each do |id, crop|
#  puts "Crop Number: #{crop['crop_number']} #{crop['description']}"
#  puts "Delay Inter: #{crop['delay_interval']}"
#  puts "Active     : #{crop['active']}"
#end
#puts "------------------------------"
#
#puts "Crops by Crop Number:"
#puts "------------------------------"
#crops_by_crop_number = cc.crops_by_crop_number
#crops_by_crop_number.each do |crop_number, crop|
#  puts "Crop Number: #{crop_number} #{crop['description']}"
#  puts "Delay Inter: #{crop['delay_interval']}"
#  puts "Active     : #{crop['active']}"
#end
#puts "------------------------------"

#puts "Subscribers:"
#puts "------------------------------"
#subscribers = cc.subscribers
#subscribers.each do |subscriber_number, subscriber|
#  puts "Subscriber #{subscriber_number}"
#end
#puts "------------------------------"
#
#puts "Subscriptions:"
#puts "------------------------------"
#subscriptions = cc.subscriptions
#subscriptions.each do |subscription_number, subscription|
#  puts "Subscription #{subscription}"
#end
#puts "------------------------------"

#  puts cc.tractor_queues

  sequence = "3"

  began_at = Time.now
  change_uuid = "change_uuid_#{sequence}"
  delivery_uuid = "delivery_change_uuid_#{sequence}"
  harvest_uuid = "harvester_uuid_#{sequence}"
  crop_number = 201
  ended_at = Time.now + (60*60)

  endpoint_response_code = 200
  endpoint_response_data = 200
  endpoint_response_date = Time.now
  endpoint_response_header = "header stuff"
  number_of_adds = 10
  number_of_changes = 100
  number_of_deletes = 1000
  old_value = "old value"
  primary_key = "new value"
  queued_at = Time.now
  subscriber_id = 1
  total_records = 10000
  transaction_type = "add"
  transaction_uuid = "transaction_uuid_#{sequence}"
  value = "value"


  cc.push_change(queued_at, harvest_uuid, change_uuid, crop_number, primary_key, transaction_type, value, old_value)
  cc.push_harvester_stats(harvest_uuid, crop_number, began_at, ended_at, total_records, number_of_changes, number_of_adds, number_of_deletes)
  cc.push_transaction(queued_at, change_uuid, transaction_uuid, crop_number, subscriber_id, primary_key, transaction_type, value, old_value)
  cc.push_delivery_status(queued_at, delivery_uuid, transaction_uuid, endpoint_response_code, endpoint_response_header, endpoint_response_data, endpoint_response_date)


#subscriptions.each do |subscription_number, subscription|
#    queues << "Tractor_#{subscription['subscriber']['id']}_#{subscription['crop']['crop_number']}"
#    #puts "subscriber_number: #{subscription['subscriber']['id']}"
#    #puts "subscriber_secret_key: #{subscription['subscriber']['secret_key']}"
#    #puts "crop_number: #{subscription['crop']['crop_number']}"
#    #puts "endpoint_url: #{subscription['endpoint_url']}"
#    #puts "endpoint_username: #{subscription['endpoint_username']}"
#    #puts "endpoint_password: #{subscription['endpoint_password']}"
#    #puts "tractor_quantity: #{subscription['tractor_quantity']}"
#    puts
#end

end


