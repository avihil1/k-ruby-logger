# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "kona-logger/version"

Gem::Specification.new do |s|
  s.name        = "kona-logger"
  s.version     = KonaLogger::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Hillel Kahana"]
  s.email       = ["hillel@kontera.com"]
  s.homepage    = ""
  s.summary     = %q{kona-logger files}
  s.description = %q{A simple logger}

  s.rubyforge_project = "kona-logger"

  #s.files         = `git ls-files`.split("\n")
  s.files         = `find .`.split("\n")
  s.require_paths = ["lib"]
  s.add_dependency('colorize')
end

