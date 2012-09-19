FactoryGirl.define do
  factory :ecm_products_product_picture, :class => Ecm::Products::ProductPicture do
    ecm_products_product
    image File.open(File.join(::Rails.root, 'spec/files', 'ecm/products/product_pictures', 'image.jpg'))
  end
end

