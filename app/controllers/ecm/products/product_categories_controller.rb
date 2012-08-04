class Ecm::Products::ProductCategoriesController < ApplicationController
  def index
    @product_categories = ::Ecm::Products::ProductCategory.includes(:ecm_products_products)
  end
  
  def show
    @product_category = ::Ecm::Products::ProductCategory.includes(:ecm_products_products).find(params[:id])
  end
end    
