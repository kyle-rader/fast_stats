
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fast_stats/version"

Gem::Specification.new do |spec|
  spec.name          = "fast_stats"
  spec.version       = FastStats::VERSION
  spec.authors       = ["Kyle Rader"]
  spec.email         = ["kyle@kylerader.ninja"]

  spec.summary       = %q{A small Ruby Gem for doing fast stats}
  spec.description   = %q{A small Ruby Gem for doing fast stats to help manage metrics calculations}
  spec.homepage      = "https://github.com/kyle-rader/fast_stats"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Development Dependencies
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "guard", "~> 2.0"
  spec.add_development_dependency "guard-rspec", "~> 4.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

  # Runtime Dependencies
  spec.add_runtime_dependency 'activesupport', '< 5.2', '>= 4.0'

end
