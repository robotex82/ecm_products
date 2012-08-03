class Ecm::Products::ProductCategory < ActiveRecord::Base
  # database settings
  self.table_name = 'ecm_products_product_categories'
  
  # associations
  has_many :ecm_products_products, 
           :class_name => Ecm::Products::Product, 
           :dependent => :destroy,
           :foreign_key => :ecm_products_product_category_id,
           :order => 'position'
  
  # attributes
  attr_accessible :depth, 
                  :lft, 
                  :locale, 
                  :long_description, 
                  :name, 
                  :parent_id, 
                  :rgt, 
                  :short_description, 
                  :slug
  
  # awesome nested set
  acts_as_nested_set
  default_scope :order => 'lft ASC'  
  
  # friendly id
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  # validations
  validates :name, :presence => true, :uniqueness => { :scope => [ :parent_id ] }
  validates :locale, :presence => true, :if => Proc.new { |pc| pc.parent.nil? } # , :if => :root?
  validates :locale, :inclusion => I18n.available_locales.map(&:to_s), :unless => Proc.new { |pc| pc.locale.blank? }
  validates :locale, :absence => true, :if => Proc.new { |pc| !pc.parent.nil? }
  
  # publid methods
  
  def to_s
    name
  end  
  
  def tree_name
    root_prefix = (self.root?) ? "[#{self.locale}] " : ""
      
    if ecm_products_products.count < 1
      "#{root_prefix}#{to_s}" 
    else 
      "#{root_prefix}#{to_s} (#{ecm_products_products.count})"     
    end
  end 
end
