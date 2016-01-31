# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rby/money'

Gem::Specification.new do |spec|
  spec.name          = "rby-money"
  spec.version       = Rby::Money::VERSION
  spec.authors       = ["Alexander Donkin"]
  spec.email         = ["alexander_donkin@yahoo.co.uk"]

  spec.summary       = "Money converting machine"
  spec.description   = "Converting impossible sums since 2016"
  spec.homepage      = "https://github.com/AlexanderRD/rby-money"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "terminal-notifier-guard"
  spec.add_development_dependency "pry"
end
