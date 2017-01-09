# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv_manager/version'

Gem::Specification.new do |spec|
  spec.name          = "csv_manager"
  spec.version       = CSVManager::VERSION
  spec.authors       = ["Gahee Heo"]
  spec.email         = ["ghbooth12@gmail.com"]

  spec.summary       = %q{Import and export a CSV file}
  spec.description   = %q{Import and export a CSV file in a very easy and simple way}
  spec.homepage      = "https://github.com/ghbooth12/csv_manager"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "activerecord", "~> 4.0"
  spec.add_development_dependency "sqlite3", "~> 1.3", ">= 1.3.13"
  spec.add_development_dependency "railties", ">= 4.2.0", "< 5.1"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10.4"
  # spec.add_development_dependency "logging"
end
