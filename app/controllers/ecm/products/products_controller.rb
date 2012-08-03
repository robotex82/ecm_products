class Ecm::Products::ProductsController < ApplicationController
  def index
    @products = ::Ecm::Products::Product.all
  end
  
  def show
    @product = ::Ecm::Products::Product.find(params[:id])
  end  
end    
