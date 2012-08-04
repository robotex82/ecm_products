FactoryGirl.define do
  factory :ecm_products_product, :class => Ecm::Products::Product do
    sequence(:name){|n| "#{Faker::Product.product_name} {n}" }
    locale "en"
    ecm_products_product_category
    main_image { fixture_file_upload(Rails.root + "spec/fixtures/product_main_image.jpg", "image/jpg") }
    preview_image { fixture_file_upload(Rails.root + "spec/fixtures/product_preview_image.jpg", "image/jpg") }
  end
end
