FactoryGirl.define do
  factory :ecm_products_product_link, :class => Ecm::Products::ProductLink do
    ecm_products_product
    sequence(:name) { |n| "#{Faker::Company.name} #{n} Link" }
    markup_language "textile"    
    sequence(:url) { |n| "#{Faker::Internet.http_url} #{n} Link" }
  end
end
