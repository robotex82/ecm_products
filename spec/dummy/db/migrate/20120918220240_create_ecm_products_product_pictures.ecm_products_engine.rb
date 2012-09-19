# This migration comes from ecm_products_engine (originally 4)
class CreateEcmProductsProductPictures < ActiveRecord::Migration
  def change
    create_table :ecm_products_product_pictures do |t|
      t.string :name
      t.text :description

      # acts as list
      t.integer :position

      # acts as markup
      t.string :markup_language

      # friendly id
      t.string :slug

      # paperclip
      # t.attachment :image
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.timestamp :image_updated_at
      t.string :image_fingerprint

      # associations
      t.references :ecm_products_product

      t.timestamps
    end
    add_index :ecm_products_product_pictures, :ecm_products_product_id
  end
end

