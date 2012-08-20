require 'spec_helper'

describe "home/index" do
  before(:all) do
    I18n.locale = :en
  end
    
  it "renders _product_category_preview partial" do
    FactoryGirl.create(:ecm_products_product_category_with_products, :name => 'Candy')
    render
    view.should render_template(:partial => "_product_category_preview", :count => 1)
  end

  it "renders _product_preview partial" do
    FactoryGirl.create(:ecm_products_product_category_with_products, :name => 'Candy')
    render
    view.should render_template(:partial => "_product_preview", :count => 1)
  end
end
