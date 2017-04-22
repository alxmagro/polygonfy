# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'polygonfy/version'

Gem::Specification.new do |spec|
  spec.name          = "polygonfy"
  spec.version       = Polygonfy::VERSION
  spec.authors       = ["Alexandre Magro"]
  spec.email         = ["alexandremagro@live.com"]

  spec.summary       = "GDraw an SVG polygon easily from the command line"
  spec.description   = "Draw an SVG polygon easily from the command line"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = ["polygonfy"]
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.7.1"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
