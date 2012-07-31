$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ecm/products/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ecm_products"
  s.version     = ECM::Products::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/robotex82/ecm_products"
  s.summary     = "Product management for active admin."
  s.description = "Product management for active admin."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.7"

  # Development Database
  s.add_development_dependency "sqlite3"
  
  # Development Server
  s.add_development_dependency "thin"
  
  # Documentation
  s.add_development_dependency "yard"
  
  # Tests
  s.add_development_dependency "capybara"    
  s.add_development_dependency "rspec-rails", "~> 2.0"
  s.add_development_dependency "factory_girl_rails", "~> 1.0"
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency "shoulda-matchers"
end
