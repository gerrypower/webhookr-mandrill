# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webhookr-mandrill/version'

Gem::Specification.new do |gem|
  gem.name          = "webhookr-mandrill"
  gem.version       = Webhookr::Mandrill::VERSION
  gem.authors       = ["Gerry Power"]
  gem.email         = ["gerry@thepowerhouse.com"]
  gem.description   = "A webhookr extension to support Mandrill webhooks."
  gem.summary       = gem.description
  gem.homepage      = "http://github.com/gerrypower/webhookr-mandrill"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("webhookr")
  gem.add_dependency("activesupport", [">= 3.1"])

end
