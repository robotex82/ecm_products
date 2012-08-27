FactoryGirl.define do
  factory :ecm_products_product_link, :class => Ecm::Products::ProductLink do
    sequence(:name) { |n| "#{Faker::Company.name} #{n} Link" }
    sequence(:url) { |n| "#{Faker::Internet.http_url} #{n} Link" }
    markup_language "textile"
  end
end
