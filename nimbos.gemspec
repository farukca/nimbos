$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nimbos/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nimbos"
  s.version     = Nimbos::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Nimbos."
  s.description = "TODO: Description of Nimbos."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  # s.add_dependency "jquery-rails"
  s.add_dependency "bcrypt-ruby", "3.0.1"
  s.add_dependency "warden", "1.2.3"
  s.add_dependency "carrierwave"
  s.add_dependency "mini_magick"
  s.add_dependency "cloudinary"
  s.add_dependency "resque"
  s.add_dependency "rolify"
  s.add_dependency "simple_form"
  s.add_dependency "client_side_validations"
  s.add_dependency "client_side_validations-simple_form"
  s.add_dependency "execjs"
  s.add_dependency "therubyracer"
  s.add_dependency "sass-rails",   "~> 3.2.3"
  s.add_dependency "coffee-rails", "~> 3.2.1"
  s.add_dependency "uglifier", ">= 1.0.3"
  s.add_dependency "eco"
  s.add_dependency "jbuilder"
  s.add_dependency "table_for_collection"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "minitest-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl", "4.1.0"
  s.add_development_dependency "turn"

end
