# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "flipstone-matchers/version"

Gem::Specification.new do |s|
  s.name        = "flipstone-matchers"
  s.version     = Flipstone::Matchers::VERSION
  s.authors     = ["David Vollbracht, Scott Conley"]
  s.email       = ["development@flipstone.com"]
  s.homepage    = "http://github.com/flipstone/flipstone-matchers"
  s.summary     = %q{Some useful RSpec matchers we've used on multiple projects}
  s.description = %q{Some useful RSpec matchers we've used on multiple projects}

  s.add_dependency 'rspec', ">= 2.6.0"

  s.rubyforge_project = "flipstone-matchers"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
