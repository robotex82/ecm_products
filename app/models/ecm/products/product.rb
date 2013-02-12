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

  # acts as markup
  acts_as_markup :language => :variable, :columns => [ :long_description, :short_description ]

  # associations
  belongs_to :ecm_products_product_category,
             :class_name => Ecm::Products::ProductCategory,
             :counter_cache => :ecm_products_products_count

  has_many :ecm_products_product_links,
           :class_name => Ecm::Products::ProductLink,
           :dependent => :destroy,
           :foreign_key => :ecm_products_product_id,
           :order => 'position'

  has_many :ecm_products_product_pictures,
           :class_name => Ecm::Products::ProductPicture,
           :dependent => :destroy,
           :foreign_key => :ecm_products_product_id,
           :order => 'position'

  # attributes
  attr_accessible :ecm_products_product_category_id,
                  :ecm_products_product_pictures_attributes,
                  :long_description,
                  :main_image,
                  :markup_language,
                  :name,
                  :position,
                  :preview_image,
                  :price,
                  :price_on_application,
                  :published_at,
                  :short_description,
                  :slug
  accepts_nested_attributes_for :ecm_products_product_links, :allow_destroy => true
  accepts_nested_attributes_for :ecm_products_product_pictures, :allow_destroy => true

  # callbacks
  after_initialize :set_defaults
  after_update :fix_updated_counters
  before_update :fix_updated_position, :if => Proc.new { |d| !position.blank? && d.ecm_products_product_category_id_changed? }

  # friendly id
  extend FriendlyId
  friendly_id :name, :use => :slugged

  # money
  monetize :price_cents, :allow_nil => true

  # paperclip
  has_attached_file :main_image,
                    :styles => Ecm::Products::Configuration.product_main_image_styles
  has_attached_file :preview_image,
                    :styles => Ecm::Products::Configuration.product_preview_image_styles

  # validations
  validates :ecm_products_product_category, :presence => true
  validates :name, :presence => true
  validates :markup_language, :presence  => true,
                              :inclusion => Ecm::Products::Configuration.markup_languages

  # publid methods
  def to_s
    name
  end

  # private methods

  private
    def fix_updated_position
      Rails.logger.debug "Fixing positions for #{self.to_s} (Moving to last)"
      add_to_list_bottom
    end

  def set_defaults
    if self.new_record?
      self.markup_language ||= Ecm::Products::Configuration.default_markup_language
    end
  end
end

