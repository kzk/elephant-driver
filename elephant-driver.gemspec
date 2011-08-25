$:.push File.expand_path("../lib", __FILE__)
require "elephant-driver/version"
require "rake"
require "date"

Gem::Specification.new do |s|
  s.name = "elephant-driver"
  s.version = ElephantDriver::VERSION
  s.authors = ["Kazuki Ohta"]
  s.date = Date.today.to_s
  s.description = "Ruby library for taiming a Hadoop cluster"
  s.summary = "Ruby library for taiming a Hadoop cluster"
  s.email = "k@treasure-data.com"
  s.files = FileList["lib/**/*", "[A-Z]*", "Rakefile", "docs/**/*"]
  s.homepage = "https://github.com/treasure-data/elephant-driver"
  s.require_paths = ["lib"]
  s.rubyforge_project = "elephant-driver"
  s.add_dependency('thrift', '>= 0.7.0')
  s.add_dependency('nokogiri', '>= 1.5.0')
end
