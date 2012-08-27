class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_defaults
  
  private
  
  def set_defaults
    @_pc = Ecm::Products::ProductCategory.first
    @_p  = Ecm::Products::Product.first
  end
end
