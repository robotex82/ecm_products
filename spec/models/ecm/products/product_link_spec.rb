require 'spec_helper'

module Ecm
  module Products
    describe ProductLink do
      subject { FactoryGirl.build(:ecm_products_product_link) }
      
      # associations
      it { should belong_to(:ecm_products_product) }
      
      # acts as list
      it { should respond_to(:move_higher) }
      
      # validations
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:url) }
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
