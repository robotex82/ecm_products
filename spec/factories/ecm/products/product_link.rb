FactoryGirl.define do
  factory :ecm_products_product_link, :class => Ecm::Products::ProductLink do
    name 'User guide v1.0'
    url 'http://example.com/user_guides/v1.0.pdf'
  end
end
