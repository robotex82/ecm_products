FactoryGirl.define do
  factory :ecm_products_product_link, :class => Ecm::Products::ProductLink do
    ecm_products_product
    sequence(:name) { |i| "Product link #{i}" }
    markup_language "textile"    
    sequence(:url) { |i| "http://www.example.com/#{i}" }
  end
end
