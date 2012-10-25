class Ecm::Products::ProductsController < ApplicationController
  def index
    if params[:ecm_products_product_category_id]
      @products = ::Ecm::Products::ProductCategory.find(params[:ecm_products_product_category_id]).ecm_products_products
    else
      @products = ::Ecm::Products::Product.all
    end
  end
  
  def show
    @product = ::Ecm::Products::Product.find(params[:id])
  end  
end    
