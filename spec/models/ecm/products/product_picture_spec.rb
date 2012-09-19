require 'spec_helper'

module Ecm
  module Products
    describe ProductPicture do
      subject { FactoryGirl.build(:ecm_products_product_picture) }

      context "acts as list" do
        it { should respond_to(:move_to_top) }
        it { should respond_to(:move_higher) }
        it { should respond_to(:move_lower) }
        it { should respond_to(:move_to_bottom) }
      end

      context "acts as markup" do
        subject { FactoryGirl.create(:ecm_products_product_picture, :description => 'h1. This is a heading') }      
        
        it { should validate_presence_of(:markup_language) }   
         
        %w(markdown textile rdoc).each do |value|
          it { should allow_value(value).for(:markup_language) }
        end

        %w(some other values that are not allowed).each do |value|
          it { should_not allow_value(value).for(:markup_language) }
        end  
        
        context "description.to_html" do
          specify { subject.description.to_html.should eq("<h1>This is a heading</h1>") }
        end
      end

      context "associations" do
        it { should belong_to(:ecm_products_product) }
      end

      context "friendly id" do
        subject { FactoryGirl.create(:ecm_products_product_picture, :name => 'Look, a slugged picture!') }
        its(:to_param) { should eq('look-a-slugged-picture') }
      end

      context "paperclip" do
      end
      
      context "validations" do
        it { should validate_presence_of(:ecm_products_product) } 
        it { should validate_presence_of(:name) } 
      end
    end
  end
end

