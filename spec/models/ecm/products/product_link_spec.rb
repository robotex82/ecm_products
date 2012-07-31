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
    end
  end
end      
