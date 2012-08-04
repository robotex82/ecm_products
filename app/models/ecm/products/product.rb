module FixUpdateCounters
  def fix_updated_counters
    self.changes.each {|key, value|
      # key should match /master_files_id/ or /bibls_id/
      # value should be an array ['old value', 'new value']
      if key =~ /_id/
        changed_class = key.sub(/_id/, '')

        # Get real class of changed attribute, so work both with namespaced/normal models
        klass = self.association(changed_class.to_sym).klass
       
        # Try to get counter cache from association options
        begin 
           counter_name = self.association(changed_class.to_sym).options[:counter_cache]
        rescue 
          # Namespaced model return a slash, split it.
          unless (counter_name = "#{self.class.name.underscore.pluralize.split("/")[1]}_count".to_sym)
            counter_name = "#{self.class.name.underscore.pluralize}_count".to_sym
          end
        end   


        klass.decrement_counter(counter_name, value[0]) unless value[0] == nil
        klass.increment_counter(counter_name, value[1]) unless value[1] == nil
      end
    }
  end 
end

ActiveRecord::Base.send(:include, FixUpdateCounters)

class Ecm::Products::Product < ActiveRecord::Base
  # database settings
  self.table_name = 'ecm_products_products'
  
  # acts as list
  acts_as_list :scope => :ecm_products_product_category 
  
  # associations
  belongs_to :ecm_products_product_category, 
             :class_name => Ecm::Products::ProductCategory, 
             :counter_cache => :ecm_products_products_count
             
  has_many :ecm_products_product_links, 
           :class_name => Ecm::Products::ProductLink, 
           :dependent => :destroy,
           :foreign_key => :ecm_products_product_id,
           :order => 'position'
  
  # attributes
  attr_accessible :locale, 
                  :long_description, 
                  :name, 
                  :position, 
                  :price_currency, 
                  :price_in_cents, 
                  :price_on_application, 
                  :published_at, 
                  :short_description, 
                  :slug
                  
  # callbacks
  after_update :fix_updated_counters
  before_update :fix_updated_position, :if => Proc.new { |d| !position.blank? && d.ecm_products_product_category_id_changed? }
                  
  # friendly id
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  # money
  monetize :price_cents, :allow_nil => true
  
  # paperclip
  has_attached_file :main_image  
  has_attached_file :preview_image  
  
  # validations 
  validates :ecm_products_product_category, :presence => true
  validates :locale, :inclusion => ['de', 'en'], :unless => Proc.new { |c| c.locale.blank? }
  validates :name, :presence => true  
#  validates_attachment_presence :main_image  
#  validates_attachment_presence :preview_image
  
  # private methods
  private 
  def fix_updated_position
    Rails.logger.debug "Fixing positions for #{self.to_s} (Moving to last)"
    add_to_list_bottom
  end
end
