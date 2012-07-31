# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120731191951) do

  create_table "ecm_products_product_categories", :force => true do |t|
    t.string   "locale"
    t.string   "name"
    t.text     "short_description"
    t.text     "long_description"
    t.integer  "ecm_products_products_count", :default => 0, :null => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "parent_id"
    t.integer  "depth"
    t.string   "slug"
    t.string   "preview_image_file_name"
    t.integer  "preview_image_file_size"
    t.string   "preview_image_content_type"
    t.datetime "preview_image_updated_at"
    t.string   "preview_image_fingerprint"
    t.string   "main_image_file_name"
    t.integer  "main_image_file_size"
    t.string   "main_image_content_type"
    t.datetime "main_image_updated_at"
    t.string   "main_image_fingerprint"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "ecm_products_product_links", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.integer  "ecm_products_product_id"
    t.integer  "position"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "ecm_products_product_links", ["ecm_products_product_id"], :name => "index_ecm_products_product_links_on_ecm_products_product_id"

  create_table "ecm_products_products", :force => true do |t|
    t.string   "locale"
    t.string   "name"
    t.text     "short_description"
    t.text     "long_description"
    t.boolean  "price_on_application"
    t.integer  "ecm_products_product_links_count", :default => 0, :null => false
    t.integer  "ecm_products_product_category_id"
    t.integer  "position"
    t.datetime "published_at"
    t.string   "slug"
    t.integer  "price_cents"
    t.string   "price_currency"
    t.string   "preview_image_file_name"
    t.integer  "preview_image_file_size"
    t.string   "preview_image_content_type"
    t.datetime "preview_image_updated_at"
    t.string   "preview_image_fingerprint"
    t.string   "main_image_file_name"
    t.integer  "main_image_file_size"
    t.string   "main_image_content_type"
    t.datetime "main_image_updated_at"
    t.string   "main_image_fingerprint"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

end
