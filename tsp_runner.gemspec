# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tsp_runner/version'

Gem::Specification.new do |spec|
  spec.name          = 'tsp_runner'
  spec.version       = TspRunner::VERSION
  spec.authors       = ['Tom Collier']
  spec.email         = ['collier@apartmentlist.com']

  spec.summary       = %q{Script to run a TSP solver and validate/measure its output.}
  spec.description   = %{qScript to run a TSP solver and validate/measure its output.}
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 10.0'
end
