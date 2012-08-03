require 'spec_helper'

describe "ecm/products/product_categories/index" do


  def add_controller_helpers *controllers
    controllers.each { |c| view.singleton_class.class_eval { include c.new._helpers } }
  end

  before do
    add_controller_helpers ApplicationController
  end


  
  it "renders _product partial for each product" do
    @product_categories = FactoryGirl.create(:ecm_products_product_category_tree).self_and_descendants
    assign(:product_categories, @product_categories)
    render
    @product_categories.each do |pc| 
      rendered.should have_content(pc.name)
    end  
  end
end
