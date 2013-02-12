require 'spec_helper'

describe "routing to product categories" do
  it "routes /ecm_products_product_categories to #index" do
    expect(:get => "/ecm_products_product_categories").to route_to(
      :controller => "ecm/products/product_categories",
      :action => "index"
    )
  end # it

  it "routes /ecm_products_product_categories/example-category to #show" do
    expect(:get => "/ecm_products_product_categories/example-category").to route_to(
      :controller => "ecm/products/product_categories",
      :action => "show",
      :id => "example-category"
    )
  end # it
end

describe "routing to products" do
  it "routes /ecm_products_products to #index" do
    expect(:get => "/ecm_products_products").to route_to(
      :controller => "ecm/products/products",
      :action => "index"
    )
  end # it

  it "routes /ecm_products_products/example-product to #show" do
    expect(:get => "/ecm_products_products/example-product").to route_to(
      :controller => "ecm/products/products",
      :action => "show",
      :id => "example-product"
    )
  end # it
end

