require 'spec_helper'

module Ecm
  module Products
    describe ProductLink do
      subject { FactoryGirl.build(:ecm_products_product_link) }
      
      context "associations" do
        it { should belong_to(:ecm_products_product) }
      end
      
      context "acts as list" do
        it { should respond_to(:move_to_top) }
        it { should respond_to(:move_higher) }
        it { should respond_to(:move_lower) }
        it { should respond_to(:move_to_bottom) }
      end
      
      context "validations" do
        it { should validate_presence_of(:ecm_products_product) } 
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:url) }
        it { should validate_presence_of(:markup_language) }
      end

      context "acts as markup" do
        %w(markdown textile rdoc).each do |value|
          it { should allow_value(value).for(:markup_language) }
        end

        %w(some other values that are not allowed).each do |value|
          it { should_not allow_value(value).for(:markup_language) }
        end
      end
    end
  end
end      
