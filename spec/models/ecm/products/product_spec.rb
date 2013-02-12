require 'spec_helper'

module Ecm
  module Products
    describe Product do
      subject { FactoryGirl.build(:ecm_products_product) }

      # associations
      it { should belong_to(:ecm_products_product_category) }
      it { should have_many(:ecm_products_product_links) }
      it { should have_many(:ecm_products_product_pictures) }

      # validations
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:ecm_products_product_category) }
      it { should validate_presence_of(:markup_language) }

      %w(markdown textile rdoc).each do |value|
        it { should allow_value(value).for(:markup_language) }
      end

      %w(some other values that are not allowed).each do |value|
        it { should_not allow_value(value).for(:markup_language) }
      end
      # it { should validate_uniqueness_of(:name).scoped_to(:ecm_products_product_category_id) }

      it "should only accept available locales" do
#        product = FactoryGirl.build(:ecm_products_product, :locale => 'invalid')
#        product.should_not be_valid
      end

      # acts as list
      it { should respond_to(:move_higher) }

      # friendly id
      it "should have a friendly id" do
        product = FactoryGirl.create(:ecm_products_product, :name => 'This is a product that should have a friendly id!')
        product.to_param.should == 'this-is-a-product-that-should-have-a-friendly-id'
      end

      # methods
      context '#to_s' do
        before do
          @product = Ecm::Products::Product.new(:name => 'Example product')
        end # before

        it 'should show the product name' do
          @product.to_s.should eq(@product.name)
        end
      end # context '#to_s'
    end
  end
end

