FactoryGirl.define do
  factory :ecm_products_product_category, :class => Ecm::Products::ProductCategory do
    name "Candy"
    locale I18n.default_locale.to_s
      
    factory :ecm_products_product_category_with_parent do
      locale nil
      association :parent, :factory => :ecm_products_product_category
    end
  end
end
