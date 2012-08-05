FactoryGirl.define do
  factory :ecm_products_product, :class => Ecm::Products::Product do
#    created_at 5.minutes.ago
#    updated_at 2.minutes.ago    
    locale "en"
    sequence(:name){|n| "#{Faker::Product.product_name} {n}" }

    ecm_products_product_category
    main_image { fixture_file_upload(Rails.root + "spec/fixtures/product_main_image.jpg", "image/jpg") }
    preview_image { fixture_file_upload(Rails.root + "spec/fixtures/product_preview_image.jpg", "image/jpg") }
  end
end
