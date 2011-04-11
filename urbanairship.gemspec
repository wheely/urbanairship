# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "urbanairship/version"

Gem::Specification.new do |s|
  s.name        = "urbanairship"
  s.version     = UrbanAirship::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Anton Chirkunov"]
  s.email       = ["anton@wheely.com"]
  s.homepage    = "http://github.com/wheely/urbanairship"
  s.summary     = %q{Use the Urban Airship API to send push notifications}
  s.description = %q{Use the Urban Airship API to send push notifications}

  s.rubyforge_project = "urbanairship"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('typhoeus')
  s.add_dependency('yajl-ruby')
  
  s.add_development_dependency('rspec')
  s.add_development_dependency('watchr')
  
end
