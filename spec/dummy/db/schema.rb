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

ActiveRecord::Schema.define(:version => 20120821153040) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

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
