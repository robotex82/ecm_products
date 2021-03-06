# This migration comes from ecm_products_engine (originally 1)
class CreateEcmProductsProductCategories < ActiveRecord::Migration
  def change
    create_table :ecm_products_product_categories do |t|
      t.string :locale
      t.string :name
      t.text :short_description
      t.text :long_description
      t.string :markup_language

      # associations
      t.integer :ecm_products_products_count, :default => 0, :null => false

      # awesome nested set
      t.integer :lft
      t.integer :rgt
      t.integer :parent_id
      t.integer :depth

      # friendly id
      t.string :slug

      # paperclip
      # t.attachment :preview_image
      t.string :preview_image_file_name
      t.integer :preview_image_file_size
      t.string :preview_image_content_type
      t.timestamp :preview_image_updated_at
      t.string :preview_image_fingerprint

      # paperclip
      # t.attachment :main_image
      t.string :main_image_file_name
      t.integer :main_image_file_size
      t.string :main_image_content_type
      t.timestamp :main_image_updated_at
      t.string :main_image_fingerprint

      t.timestamps
    end
  end
end
