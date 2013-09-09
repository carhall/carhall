# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130908053422) do

  create_table "activities", :force => true do |t|
    t.integer  "dealer_id"
    t.string   "title"
    t.datetime "expire_at"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "base_orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "dealer_id"
    t.integer  "review_id"
    t.integer  "detail_id"
    t.string   "detail_type"
    t.integer  "source_id"
    t.string   "source_type"
    t.string   "title"
    t.integer  "state_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "base_orders", ["detail_type", "detail_id"], :name => "index_base_orders_on_detail_type_and_detail_id"
  add_index "base_orders", ["source_type", "source_id"], :name => "index_base_orders_on_source_type_and_source_id"
  add_index "base_orders", ["state_id"], :name => "index_base_orders_on_state_id"
  add_index "base_orders", ["user_id"], :name => "index_base_orders_on_user_id"

  create_table "base_users", :force => true do |t|
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_mobile"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username",               :default => "", :null => false
    t.string   "mobile",                 :default => "", :null => false
    t.text     "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "accepted_at"
    t.integer  "detail_id"
    t.string   "detail_type"
  end

  add_index "base_users", ["authentication_token"], :name => "index_base_users_on_authentication_token", :unique => true
  add_index "base_users", ["confirmation_token"], :name => "index_base_users_on_confirmation_token", :unique => true
  add_index "base_users", ["detail_type", "detail_id"], :name => "index_base_users_on_detail_type_and_detail_id"
  add_index "base_users", ["mobile"], :name => "index_base_users_on_mobile"
  add_index "base_users", ["reset_password_token"], :name => "index_base_users_on_reset_password_token", :unique => true
  add_index "base_users", ["unlock_token"], :name => "index_base_users_on_unlock_token", :unique => true
  add_index "base_users", ["username"], :name => "index_base_users_on_username"

  create_table "blocks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "blacklist_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "blocks", ["blacklist_id"], :name => "index_blocks_on_blacklist_id"
  add_index "blocks", ["user_id"], :name => "index_blocks_on_user_id"

  create_table "bulk_purchasing_order_details", :force => true do |t|
    t.float   "price"
    t.integer "count"
  end

  create_table "bulk_purchasings", :force => true do |t|
    t.integer  "dealer_id"
    t.string   "title"
    t.datetime "expire_at"
    t.integer  "bulk_purchasing_type_id"
    t.float    "price"
    t.float    "vip_price"
    t.text     "description"
    t.integer  "bulk_purchasing_orders_count"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "cleaning_order_details", :force => true do |t|
    t.float   "price"
    t.integer "count"
    t.integer "used_count"
  end

  create_table "cleanings", :force => true do |t|
    t.integer  "dealer_id"
    t.string   "title"
    t.integer  "cleaning_type_id"
    t.float    "price"
    t.float    "vip_price"
    t.text     "description"
    t.integer  "cleaning_orders_count"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "clubs", :force => true do |t|
    t.integer  "president_id"
    t.string   "president_candidate_ids"
    t.string   "mechanic_ids"
    t.string   "mechanic_candidate_ids"
    t.string   "title"
    t.string   "announcement"
    t.integer  "area_id"
    t.integer  "brand_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "clubs", ["area_id", "brand_id"], :name => "index_clubs_on_area_id_and_brand_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.string   "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "comments", ["source_type", "source_id"], :name => "index_comments_on_source_type_and_source_id"

  create_table "dealer_details", :force => true do |t|
    t.integer  "dealer_type_id"
    t.string   "business_scope_ids"
    t.string   "company"
    t.string   "address"
    t.string   "phone"
    t.string   "open_during"
    t.integer  "balance",              :default => 0, :null => false
    t.string   "rqrcode_token"
    t.string   "reg_img_file_name"
    t.string   "reg_img_content_type"
    t.integer  "reg_img_file_size"
    t.datetime "reg_img_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "template_ids"
    t.integer  "balance_used",         :default => 0, :null => false
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "mending_order_details", :force => true do |t|
    t.float    "price"
    t.integer  "brand_id"
    t.string   "series"
    t.string   "plate_num"
    t.datetime "arrive_at"
    t.text     "description"
  end

  create_table "mendings", :force => true do |t|
    t.integer  "dealer_id"
    t.text     "discount"
    t.text     "brand_ids"
    t.text     "description"
    t.integer  "mending_orders_count"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "post_blocks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "blacklist_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "post_blocks", ["blacklist_id"], :name => "index_post_blocks_on_blacklist_id"
  add_index "post_blocks", ["user_id"], :name => "index_post_blocks_on_user_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "club_id"
    t.string   "content"
    t.integer  "view_count",         :default => 0
    t.integer  "comments_count",     :default => 0
    t.float    "weight",             :default => 0.0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "posts", ["club_id"], :name => "index_posts_on_club_id"
  add_index "posts", ["comments_count"], :name => "index_posts_on_comments_count"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"
  add_index "posts", ["view_count"], :name => "index_posts_on_view_count"

  create_table "provider_details", :force => true do |t|
    t.string "company"
    t.string "phone"
    t.string "rqrcode_token"
  end

  create_table "reviews", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "stars"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_details", :force => true do |t|
    t.integer  "sex_id"
    t.integer  "area_id"
    t.integer  "brand_id"
    t.string   "series"
    t.string   "plate_num"
    t.integer  "balance",              :default => 0, :null => false
    t.string   "reg_img_file_name"
    t.string   "reg_img_content_type"
    t.integer  "reg_img_file_size"
    t.datetime "reg_img_updated_at"
  end

  add_index "user_details", ["area_id", "brand_id"], :name => "index_user_details_on_area_id_and_brand_id"

end
