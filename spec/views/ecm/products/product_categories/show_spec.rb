require 'spec_helper'

describe "ecm/products/product_categories/show" do


  def add_controller_helpers *controllers
    controllers.each { |c| view.singleton_class.class_eval { include c.new._helpers } }
  end

  before do
    add_controller_helpers ApplicationController
  end

  it "renders _product_category partial" do
    @product_category = FactoryGirl.create(:ecm_products_product_category_tree)
    assign(:product_category, @product_category)
    render
    view.should render_template(:partial => "_product_category", :count => 1)
  end
  
  it "show the category name in a heading" do
    product_category = FactoryGirl.create(:ecm_products_product_category_tree)
    assign(:product_category, product_category)
    render
    rendered.should have_content(product_category.name)
  end  
  
  it "renders all sub categories" do
    @product_category = FactoryGirl.create(:ecm_products_product_category_tree)
    @sub_product_categories = @product_category.descendants
    assign(:product_category, @product_category)
    render
    @sub_product_categories.each do |pc| 
      rendered.should have_content(pc.name)
    end  
  end
end
