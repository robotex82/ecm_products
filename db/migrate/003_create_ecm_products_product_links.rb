class CreateEcmProductsProductLinks < ActiveRecord::Migration
  def change
    create_table :ecm_products_product_links do |t|
      t.string :name
      t.string :url
      t.text :description
      t.string :markup_language

      # associations
      t.references :ecm_products_product

      # acts as list
      t.integer :position

      t.timestamps
    end
    add_index :ecm_products_product_links, :ecm_products_product_id
  end
end
