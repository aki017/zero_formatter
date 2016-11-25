# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zero_formatter/version'

Gem::Specification.new do |spec|
  spec.name          = "zero_formatter"
  spec.version       = ZeroFormatter::VERSION
  spec.authors       = ["aki017"]
  spec.email         = ["aki@aki017.info"]

  spec.summary       = %q{ZeroFormatter ruby port}
  spec.description   = %q{ZeroFormatter ruby port}
  spec.homepage      = "https://github.com/aki017/zeroformatter.rb"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "guard", "~> 2.14.0"
  spec.add_development_dependency "guard-minitest", "~> 2.4.6"
  spec.add_development_dependency "simplecov", "~> 0.12.0"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 1.0.3"
  spec.add_development_dependency "minitest-reporters", "~> 1.1.12"

end
