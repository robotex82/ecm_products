require 'spec_helper'

module Ecm
  module Products
    describe ProductsController do
      describe "GET index" do
        it "assigns all ecm_products_products to @products" do
          product = FactoryGirl.create(:ecm_products_product)
          get :index
          assigns(:products).should eq([product])
        end
      end
      
      describe "GET show" do
        it "assigns a ecm_products_product to @product" do
          product = FactoryGirl.create(:ecm_products_product)
          get :show, :id => product
          assigns(:product).should eq(product)
        end
      end      
    end
  end
end    
