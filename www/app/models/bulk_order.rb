class BulkOrder < ActiveRecord::Base
  belongs_to :crop
  belongs_to :subscriber
end
