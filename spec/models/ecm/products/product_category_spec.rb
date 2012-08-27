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
#        product_category = FactoryGirl.build(:ecm_products_product_category, :locale => 'invalid')
#        product_category.should_not be_valid
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
        product_category = FactoryGirl.create(:ecm_products_product_category_with_products)
#        10.times do
#          p = FactoryGirl.build(:ecm_products_product)
#          product_category.ecm_products_products << p
#          p.save!
##          p = FactoryGirl.build(:ecm_products_product, :ecm_products_product_category_id => product_category)
##          p.save!
#        end
        product_category.ecm_products_products_count.should == 1
        product_category.tree_name.should =~ /(.*)\(1\)/
      end

      it { should validate_presence_of(:markup_language) }

      %w(markdown textile rdoc).each do |value|
        it { should allow_value(value).for(:markup_language) }
      end

      %w(some other values that are not allowed).each do |value|
        it { should_not allow_value(value).for(:markup_language) }
      end
    end
  end
end
