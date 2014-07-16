# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "index_for/version"

Gem::Specification.new do |s|
  s.name        = "index_for"
  s.version     = IndexFor::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Wrap your objects with a helper to easily list them"
  s.email       = "bbtfrr@gmail.com"
  s.homepage    = "http://github.com/bbtfr/index_for"
  s.description = "Wrap your objects with a helper to easily list them"
  s.authors     = ['bbtfr']

  s.files         = Dir["CHANGELOG.rdoc", "MIT-LICENSE", "README.rdoc", "lib/**/*"]
  s.test_files    = Dir["test/**/*"]
  s.require_paths = ["lib"]

  s.rubyforge_project = "index_for"

  s.add_dependency('show_for', '>= 0.3.0.rc')
  s.add_dependency('activemodel', '>= 3.2', '< 5')
  s.add_dependency('actionpack', '>= 3.2', '< 5')
end
