FactoryGirl.define do
  factory :ecm_products_product, :class => Ecm::Products::Product do   
    sequence(:name) {|n| "#{Faker::Product.product_name} #{n}" }
    markup_language "textile"
    
    ecm_products_product_category
    
    factory :ecm_products_product_with_main_image do |product|
      main_image { fixture_file_upload(Rails.root + "spec/fixtures/product/main_image.gif", "image/gif") }
    end
    
    factory :ecm_products_product_with_preview_image do |product|
      preview_image { fixture_file_upload(Rails.root + "spec/fixtures/product/preview_image.gif", "image/gif") }
    end
    
    factory :ecm_products_product_with_links do |product|
      product.after_create { |p| FactoryGirl.create_list(:ecm_products_product_link, 10,:ecm_products_product => p) }
      product.ecm_products_product_links_count 10
    end    
  end
end
