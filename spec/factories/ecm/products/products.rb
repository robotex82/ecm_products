FactoryGirl.define do
  factory :ecm_products_product, :class => Ecm::Products::Product do
    sequence(:name) {|n| "#{Faker::Product.product_name} #{n}" }
    markup_language "textile"

    ecm_products_product_category

    factory :ecm_products_product_with_main_image do |product|
      main_image { File.open(ECM::Products::Engine.root + "spec/files/ecm/products/product/main_image.gif") }
    end

    factory :ecm_products_product_with_preview_image do |product|
      preview_image { File.open(ECM::Products::Engine.root + "spec/files/ecm/products/product/preview_image.gif") }
    end

    factory :ecm_products_product_with_links do |product|
      product.after_create { |p| FactoryGirl.create_list(:ecm_products_product_link, 10,:ecm_products_product => p) }
      product.ecm_products_product_links_count 10
    end

    factory :ecm_products_product_with_pictures do |product|
      product.after_create { |p| FactoryGirl.create_list(:ecm_products_product_picture, 10, :ecm_products_product => p) }
      product.ecm_products_product_pictures_count 10
    end
  end
end

