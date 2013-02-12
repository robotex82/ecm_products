source "http://rubygems.org"

# Declare your gem's dependencies in ecm_pictures.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

# Edge active admin
gem 'activeadmin', :git => 'git://github.com/gregbell/active_admin.git'

# Patched guard rails
gem 'guard-rails',  :git => 'git://github.com/robotex82/guard-rails.git', :branch => 'better-engine-support'

## Acts as published
#gem 'acts_as_published',  :path => '/home/robo/rails/modules/acts_as_published-master'

## Active admin awesome nested set
#gem 'active_admin-awesome_nested_set',  :path => '/home/robo/rails/modules/active_admin-awesome_nested_set'

unless ENV['TRAVIS_RUBY_VERSION'].nil?
  gem 'pg'
  gem 'mysql2'
end
