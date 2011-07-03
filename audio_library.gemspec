# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'audio_library'

Gem::Specification.new do |s|
  s.name        = "audio_library"
  s.version     = AudioLibrary::VERSION
  s.authors     = ["Mark Ryall"]
  s.email       = ["mark@ryall.name"]
  s.homepage    = "http://github.com/markryall/audio_library"
  s.summary     = %q{rapidly and efficiently extract id3 tags from a large music collection}
  s.description = %q{he eventual goal is to used this to create a tool to clean up tags}

  s.rubyforge_project = "audio_library"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end