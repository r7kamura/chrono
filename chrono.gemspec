lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "chrono/version"

Gem::Specification.new do |spec|
  spec.name          = "chrono"
  spec.version       = Chrono::VERSION
  spec.authors       = ["Ryo Nakamura"]
  spec.email         = ["r7kamura@gmail.com"]
  spec.summary       = "Provides a chain of logics about chronology."
  spec.homepage      = "https://github.com/r7kamura/chrono"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.4.0"
  spec.add_development_dependency "simplecov"
end
