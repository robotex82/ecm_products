FactoryGirl.define do
  factory :ecm_products_product, :class => Ecm::Products::Product do
    name "Candy Bar"
    ecm_products_product_category
    main_image { fixture_file_upload(Rails.root + "spec/fixtures/product_main_image.jpg", "image/jpg") }
    preview_image { fixture_file_upload(Rails.root + "spec/fixtures/product_preview_image.jpg", "image/jpg") }
  end
end
