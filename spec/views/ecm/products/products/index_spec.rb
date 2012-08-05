require 'spec_helper'

describe "ecm/products/products/index" do
  it "renders _product_preview partial for each product" do
    assign(:products, [stub_model(Ecm::Products::Product), stub_model(Ecm::Products::Product)])
    render
    view.should render_template(:partial => "_product_preview", :count => 2)
  end
  
  it "shows headings for all products" do
    products = FactoryGirl.create_list(:ecm_products_product, 5)
    assign(:products, products)
    render
    products.each do |p|
      rendered.should have_selector("h2", :text => p.name)
    end
  end
  
  it "shows links to all products" do
    products = FactoryGirl.create_list(:ecm_products_product, 5)
    assign(:products, products)
    render
    products.each do |product|
      rendered.should have_link("more", :href => "/ecm_products_products/#{product.to_param}")
    end
  end
end
