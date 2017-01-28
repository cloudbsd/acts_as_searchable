$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_searchable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name        = "acts_as_searchable"
  gem.version     = ActsAsSearchable::VERSION
  gem.authors     = ["Qi Li"]
  gem.email       = ["cloudbsd@gmail.com"]
  gem.homepage    = "http://github.com/cloudbsd/acts_as_searchable"
  gem.summary     = "Acts As Votable Gem."
  gem.description = "ActsAsSearchable gem provides full text search feature for database tables."
  gem.license     = 'MIT'

  gem.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "README.rdoc"]
  gem.files       = `git ls-files`.split($/)
  gem.test_files  = Dir["test/**/*"]
  gem.required_ruby_version     = '>= 1.9.3'

  gem.add_dependency 'rails',  ['>= 4.1', '< 6']
# gem.add_dependency 'activerecord',  ['>= 4.1', '< 6']

  gem.add_development_dependency "sqlite3"
end
