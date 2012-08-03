class Ecm::Products::ProductCategoriesController < ApplicationController
  def index
    @product_categories = ::Ecm::Products::ProductCategory.all
  end
  
  def show
    @product_category = ::Ecm::Products::ProductCategory.find(params[:id])
  end
end    
