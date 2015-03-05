$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nimbos/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nimbos"
  s.version     = Nimbos::VERSION
  s.authors     = ["Faruk Celik"]
  s.email       = ["farukca@yahoo.com"]
  s.homepage    = "TODO"
  s.summary     = "General nimbos auth engine."
  s.description = "User, Account, Role processes."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "4.2.0"
  # s.add_dependency "jquery-rails"
  s.add_dependency "bcrypt-ruby", "~> 3.1.2"
  s.add_dependency "warden", "1.2.3"
  s.add_dependency "carrierwave"
  s.add_dependency "mini_magick"
  s.add_dependency "cloudinary"
  s.add_dependency "resque"
  #s.add_dependency "simple_form", "~> 3.0.0"
  s.add_dependency "execjs"
  s.add_dependency "therubyracer"
  s.add_dependency "sass-rails",   "~> 4.0.0"
  s.add_dependency "coffee-rails", "~> 4.0.0"
  s.add_dependency "uglifier", ">= 1.3.0"
  s.add_dependency "eco"
  s.add_dependency "jbuilder"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "minitest-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl", "4.1.0"
  s.add_development_dependency "turn"
end
