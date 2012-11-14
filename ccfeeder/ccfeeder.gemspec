# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ccfeeder/version'

Gem::Specification.new do |gem|
  gem.name          = "ccfeeder"
  gem.version       = CcFeeder::VERSION
  gem.authors       = ["Jon Gillies"]
  gem.email         = ["jon@gillies.us"]
  gem.description   = %q{Feeds the Cache Cow}
  gem.summary       = %q{REST API to the Cache Cow}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]


  gem.add_dependency 'uuid'
  gem.add_dependency 'rest-client'
  gem.add_dependency 'crack'
  gem.add_dependency 'chronic'
  gem.add_dependency 'json'

end
