FactoryGirl.define do
  factory :ecm_products_product_category, :class => Ecm::Products::ProductCategory do
    sequence(:name){|n| "#{Faker::Product.product_name} #{n}" }
    locale "en"
      
    factory :ecm_products_product_category_with_parent do
      locale nil
      association :parent, :factory => :ecm_products_product_category
    end
    
    factory :ecm_products_product_category_with_products do |product_category|
      product_category.after_create { |pc| Factory.create(:ecm_products_product, :ecm_products_product_category => pc) }
      product_category.ecm_products_products_count 1
    end
    
    factory :ecm_products_product_category_with_main_image do |product_category|
      product_category.main_image { fixture_file_upload(Rails.root + "spec/fixtures/product_category/main_image.gif", "image/gif") }
    end  
    
    factory :ecm_products_product_category_with_preview_image do |product_category|
      product_category.main_image { fixture_file_upload(Rails.root + "spec/fixtures/product_category/preview_image.gif", "image/gif") }
    end  
  end
end

FactoryGirl.define do
  factory :ecm_products_product_category_tree, :class => Ecm::Products::ProductCategory do
    name "1.1"
    locale "en"
    after_build do |pc|
      pc.children << Factory.create(:ecm_products_product_category, :name => "#{pc.level.ordinalize} Level", :locale => nil, :parent => pc) if pc.root?
      pc.root.reload
    end
  end
end
