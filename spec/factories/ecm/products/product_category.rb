FactoryGirl.define do
  factory :ecm_products_product_category, :class => Ecm::Products::ProductCategory do
    sequence(:name){|n| "#{Faker::Product.product_name} #{n}" }
    locale "en"
      
    factory :ecm_products_product_category_with_parent do
      locale nil
      association :parent, :factory => :ecm_products_product_category
    end
  end
end

FactoryGirl.define do
  factory :ecm_products_product_category_tree, :class => Ecm::Products::ProductCategory do
    name "1.1"
    locale "en"
    after_build do |pc|
      pc.children << Factory.create(:ecm_products_product_category, :name => "#{pc.level.ordinalize} Level", :locale => nil, :parent => pc) if pc.root?
      pc.root.reload
    end
  end
end
