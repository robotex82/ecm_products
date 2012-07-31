class CreateEcmProductsProducts < ActiveRecord::Migration
  def change
    create_table :ecm_products_products do |t|
      t.string :locale
      t.string :name
      t.text :short_description
      t.text :long_description
      t.boolean :price_on_application   
      
      # associations
      t.references :ecm_products_product_category   
      
      # acts as list
      t.integer :position

      # acts as published
      t.timestamp :published_at
      
      # friendly id
      t.string :slug
      
      # money
      t.integer :price_cents
      t.string :price_currency
      
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
