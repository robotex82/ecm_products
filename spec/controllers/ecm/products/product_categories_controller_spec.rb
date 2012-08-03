require 'spec_helper'

module Ecm
  module Products
    describe ProductCategoriesController do
      describe "GET index" do
        it "assigns all ecm_products_product_categories to @product_categories" do
          product_category = FactoryGirl.create(:ecm_products_product_category)
          get :index
          assigns(:product_categories).should eq([product_category])
        end
      end
      
      describe "GET show" do
        it "assigns a ecm_products_product_category to @product_category" do
          product_category = FactoryGirl.create(:ecm_products_product_category)
          get :show, :id => product_category
          assigns(:product_category).should eq(product_category)
        end
      end
    end
  end
end    
