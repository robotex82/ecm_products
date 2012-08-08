class Ecm::Products::ProductLink < ActiveRecord::Base
  # database settings
  self.table_name = 'ecm_products_product_links'
  
  # acts as list
  acts_as_list :scope => :ecm_products_product 
  
  # associations
  belongs_to :ecm_products_product, 
             :class_name => Ecm::Products::Product, 
             :counter_cache => :ecm_products_product_links_count
  
  # attributes
  attr_accessible :description,
                  :ecm_products_product_id,
                  :name, 
                  :position, 
                  :url
  
  # validations
  validates :name, :presence => true, :uniqueness => { :scope => [ :ecm_products_product_id ] }
  validates :url,  :presence => true, :uniqueness => { :scope => [ :ecm_products_product_id ] }
end
