$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "qg/icol/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "qg-icol"
  s.version     = Qg::Icol::VERSION
  s.authors     = ["divyajayan"]
  s.email       = ["divya.jayan@quantiguous.com"]
  s.homepage    = "http://apibanking.com/"
  s.summary     = "I-Collect"
  s.description = "I-Collect"
  s.license     = "MIT"

  s.metadata['allowed_push_host'] = 'https://oQrmd9sJbFtYSixtZKSR@gem.fury.io/quantiguous/'

  s.files = Dir["{app,config,db,lib,spec}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "7.0.4"
  s.add_development_dependency 'searcher_generator', "1.0.2"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "gemfury"
end
