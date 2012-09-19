class Ecm::Products::ProductPicture < ActiveRecord::Base
  # database settings
  self.table_name = 'ecm_products_product_pictures'

  # acts as list
  acts_as_list :scope => :ecm_products_product

  # acts as markup
  acts_as_markup :language => :variable, :columns => [ :description ]

  # associations
  belongs_to :ecm_products_product,
             :class_name => Ecm::Products::Product,
             :counter_cache => :ecm_products_product_pictures_count

  # attributes
  attr_accessible :description,
                  :ecm_products_product_id,
                  :image_content_type,
                  :image,
                  :markup_language,
                  :name,
                  :position,
                  :slug

  # callbacks
  after_initialize :set_defaults
  before_validation :set_name_from_image_file_name, :if => Proc.new { |p| p.name.nil? || p.name.empty? }

  # constants
  MARKUP_LANGUAGES = %w(markdown textile rdoc)

  # friendly id
  extend FriendlyId
  friendly_id :name, :use => :slugged

  # paperclip
  has_attached_file :image,
                    :styles => {
                      :medium_thumb => "160x120",
                      :big_thumb => "360x268"
                    }

  # validations
  validates :ecm_products_product, :presence => true
  validates :markup_language, :presence  => true,
                              :inclusion => MARKUP_LANGUAGES
  validates :name, :presence => true

  private

  def set_defaults
    if self.new_record?
      self.markup_language ||= 'textile'
    end
  end

  def set_name_from_image_file_name
    self.name = File.basename(image_file_name, File.extname(image_file_name)) unless image_file_name.nil?
  end
end

