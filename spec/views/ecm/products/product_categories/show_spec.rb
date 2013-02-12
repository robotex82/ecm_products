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

  it "shows the category name" do
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

  it "shows a link to the category index when the category is a root" do
    @product_category = FactoryGirl.create(:ecm_products_product_category, :parent_id => nil)
    assign(:product_category, @product_category)
    render
    rendered.should have_xpath("//a[@href='/ecm_products_product_categories']")
  end

  it "shows a link to the parent category index when the category is not a root" do
    @product_category = FactoryGirl.create(:ecm_products_product_category_with_parent)
    assign(:product_category, @product_category)
    render
    rendered.should have_xpath("//a[@href='/ecm_products_product_categories/#{@product_category.parent.to_param}']")
  end

  it "shows the product category short description" do
    @product_category = FactoryGirl.create(:ecm_products_product_category, :short_description => 'This is the short description')
    assign(:product_category, @product_category)
    render
    rendered.should have_selector("p", :text => @product_category.short_description)
  end

  it "shows the product category long description" do
    @product_category = FactoryGirl.create(:ecm_products_product_category, :long_description => 'This is the long description')
    assign(:product_category, @product_category)
    render
    rendered.should have_selector("p", :text => @product_category.long_description)
  end

  it "shows the products" do
    @product_category = FactoryGirl.create(:ecm_products_product_category_with_products)
    assign(:product_category, @product_category)
    render
    @product_category.ecm_products_products.each do |p|
      rendered.should have_selector("h5", :text => p.name)
    end
  end
end

