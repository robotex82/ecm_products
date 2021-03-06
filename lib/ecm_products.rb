require 'active_admin-acts_as_list'
require 'active_admin-awesome_nested_set'
require 'acts_as_list'
# require 'acts_as_published'
require 'acts_as_markup'
require 'awesome_nested_set'
require 'awesome_nested_set-tools'
require 'friendly_id'
require 'money-rails'
require 'paperclip'
require 'rails_tools-absence_validator'

require 'ecm/products/engine'
require 'ecm/products/configuration'
require 'ecm/products/routing'

module Ecm
  module Products
    extend Configuration
  end
end

