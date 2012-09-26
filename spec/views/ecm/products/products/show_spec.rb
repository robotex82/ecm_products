require 'spec_helper'

describe "ecm/products/products/show" do
  def add_controller_helpers *controllers
    controllers.each { |c| view.singleton_class.class_eval { include c.new._helpers } }
  end

  before do
    add_controller_helpers ApplicationController
  end

  it "renders _product partial" do
    @product = FactoryGirl.create(:ecm_products_product)
    assign(:product, @product)
    render
    view.should render_template(:partial => "_product_details", :count => 1)
  end

  it "shows the product name" do
    product = FactoryGirl.create(:ecm_products_product)
    assign(:product, product)
    render
    rendered.should have_content(product.name)
  end

  it "shows the product main image big thumb" do
    product = FactoryGirl.create(:ecm_products_product_with_main_image)
    assign(:product, product)
    render
    rendered.should have_selector("img", :src => product.main_image.url)
  end

  it "shows the product short description" do
    product = FactoryGirl.create(:ecm_products_product, :short_description => "This is the short description")
    assign(:product, product)
    render
    rendered.should have_selector("div.product-short_description", :text => product.short_description)
  end

  it "shows the product long description" do
    product = FactoryGirl.create(:ecm_products_product, :long_description => "This is the long description")
    assign(:product, product)
    render
    rendered.should have_selector("div.product-long_description", :text => product.long_description)
  end

  it "shows the product price if available" do
    product = FactoryGirl.create(:ecm_products_product, :price => Money.new(19.99, "EUR"))
    assign(:product, product)
    render
    rendered.should have_selector("div.product-price", :text => "#{product[:curency]}#{product[:price]}")
  end

  it "shows product pictures" do
    product = FactoryGirl.create(:ecm_products_product_with_pictures)
    assign(:product, product)
    render
    product.ecm_products_product_pictures.each do |picture|
      rendered.should have_selector("img", :src => picture.image.url(:medium_thumb))
    end
  end

  it "shows product links" do
    product = FactoryGirl.create(:ecm_products_product_with_links)
    assign(:product, product)
    render
    product.ecm_products_product_links.each do |link|
      rendered.should have_selector("a", :href => link.url)
    end
  end

  it "shows a link to go back to the product category" do
    product = FactoryGirl.create(:ecm_products_product)
    assign(:product, product)
    render
    rendered.should have_selector("a", :href => "/ecm_products_product_categories/#{product.ecm_products_product_category}")
  end
end

