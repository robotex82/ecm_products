require 'spec_helper'

describe "ecm/products/products/index" do
  it "renders _product partial for each product" do
    assign(:products, [stub_model(Ecm::Products::Product), stub_model(Ecm::Products::Product)])
    render
    view.should render_template(:partial => "_product", :count => 2)
  end
end
