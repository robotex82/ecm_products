class Ecm::Products::ProductCategory < ActiveRecord::Base
  # database settings
  self.table_name = 'ecm_products_product_categories'
  
  # acts as markup
  acts_as_markup :language => :variable, :columns => [ :long_description, :short_description ]
  
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
                  :main_image,
                  :markup_language,
                  :name, 
                  :parent_id, 
                  :preview_image,
                  :rgt, 
                  :short_description, 
                  :slug
  
  # awesome nested set
  acts_as_nested_set
  default_scope :order => 'lft ASC'  
  
  # callbacks
  after_initialize :set_defaults   
  
  # constants
  MARKUP_LANGUAGES = %w(markdown textile rdoc)  
  
  # friendly id
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  # paperclip
  has_attached_file :main_image, :styles => { :medium_thumb => "160x120", :big_thumb => "360x268" }  
  has_attached_file :preview_image, :styles => { :small_thumb => "64x48",  :medium_thumb => "160x120", :big_thumb => "360x268" }   
  
  # validations
  validates :name, :presence => true, :uniqueness => { :scope => [ :parent_id ] }
  validates :locale, :presence => true, :if => Proc.new { |pc| pc.parent.nil? } # , :if => :root?
  validates :locale, :absence => true, :if => Proc.new { |pc| !pc.parent.nil? }
  validate  :available_locale, :if => Proc.new { |pc| pc.locale.present? }
  validates :markup_language, :presence  => true, 
                              :inclusion => MARKUP_LANGUAGES
  
  # public methods
  
  def to_s
    name
  end  
  
  def tree_name
    root_prefix = (self.root?) ? "[#{self.locale}] " : ""
      
    if self.ecm_products_products_count == 0
      "#{root_prefix}#{to_s}" 
    else 
      "#{root_prefix}#{to_s} (#{self.ecm_products_products_count})"     
    end
  end 
  
  def self.for_actual_locale
    # where(:locale => I18n.locale)  
    t = self.arel_table
    where(t[:locale].eq(I18n.locale).or(t[:locale].eq(nil)))
  end
  
  private
  
    def available_locale
      I18n.available_locales.map(&:to_s).include?(self.locale)
    end

    def set_defaults
      if self.new_record?
        self.markup_language ||= 'textile'
      end  
    end
end 
