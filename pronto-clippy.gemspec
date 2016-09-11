# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pronto/clippy/version'

Gem::Specification.new do |spec|
  spec.name          = 'pronto-clippy'
  spec.version       = Pronto::Clippy::VERSION
  spec.authors       = ['Łukasz Jan Niemier']
  spec.email         = ['lukasz@niemier.pl']

  spec.summary       = 'Clippy runner for Pronto'
  spec.description   = 'Clippy runner for Pronto'
  spec.homepage      = 'https://github.com/hauleth/pronto-clippy'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'pronto', '~> 0.6'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
