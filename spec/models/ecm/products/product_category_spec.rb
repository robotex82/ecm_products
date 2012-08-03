require 'spec_helper'

module Ecm
  module Products
    describe ProductCategory do
      subject { FactoryGirl.build(:ecm_products_product_category) }
      
      it { should have_many(:ecm_products_products) }
      
      it "should respond to root" do
        product_category = FactoryGirl.create(:ecm_products_product_category)
        product_category.should respond_to(:root)
      end
      
      it "should require a locale if it is a root node" do
        product_category = FactoryGirl.create(:ecm_products_product_category)
        product_category.should be_root
        
        product_category.locale = nil
        product_category.should_not be_valid
      end
      
      it "should not accept a locale if it is not a root node" do
        product_category = FactoryGirl.create(:ecm_products_product_category_with_parent)
        product_category.should_not be_root
        
        product_category.locale = I18n.locale
        product_category.should_not be_valid
      end
      
      it "should only accept available locales" do
        product_category = FactoryGirl.build(:ecm_products_product_category, :locale => 'invalid')
        product_category.should_not be_valid      
      end
      
      it "should have a friendly id" do
        product_category = FactoryGirl.create(:ecm_products_product_category, :name => 'Look, a slugged category!')
        product_category.to_param.should == 'look-a-slugged-category'
      end
      
      it "should have a correct tree name" do
        product_category = FactoryGirl.create(:ecm_products_product_category, :name => 'Fruits', :locale => 'en')
        product_category.tree_name.should == '[en] Fruits'
      end
      
      it "should display the products count in the tree name" do
        product_category = FactoryGirl.create(:ecm_products_product_category)
        10.times { FactoryGirl.create(:ecm_products_product, :ecm_products_product_category => product_category) }
        product_category.ecm_products_products.count.should == 10
        product_category.tree_name.should =~ /(.*)\(10\)/
      end      
    end
  end
end    
