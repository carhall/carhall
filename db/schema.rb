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

ActiveRecord::Schema.define(:version => 20130923120029) do

  create_table "accounts", :force => true do |t|
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
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
    t.string   "type"
    t.integer  "detail_id"
    t.string   "username",               :default => "", :null => false
    t.string   "mobile",                 :default => "", :null => false
    t.text     "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "accepted_at"
  end

  add_index "accounts", ["accepted_at"], :name => "index_accounts_on_accepted_at"
  add_index "accounts", ["authentication_token"], :name => "index_accounts_on_authentication_token", :unique => true
  add_index "accounts", ["confirmation_token"], :name => "index_accounts_on_confirmation_token", :unique => true
  add_index "accounts", ["detail_id"], :name => "index_accounts_on_detail_id"
  add_index "accounts", ["mobile"], :name => "index_accounts_on_mobile", :unique => true
  add_index "accounts", ["reset_password_token"], :name => "index_accounts_on_reset_password_token", :unique => true
  add_index "accounts", ["type", "id"], :name => "index_accounts_on_type_and_id"
  add_index "accounts", ["unlock_token"], :name => "index_accounts_on_unlock_token", :unique => true
  add_index "accounts", ["username"], :name => "index_accounts_on_username"

  create_table "activities", :force => true do |t|
    t.integer  "dealer_id"
    t.integer  "location_id"
    t.integer  "area_id"
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

  add_index "activities", ["area_id"], :name => "index_activities_on_area_id"
  add_index "activities", ["dealer_id"], :name => "index_activities_on_dealer_id"
  add_index "activities", ["location_id"], :name => "index_activities_on_location_id"

  create_table "apply", :force => true do |t|
    t.integer "from_user_id"
    t.integer "to_user_id"
    t.text    "content"
    t.integer "created_at",   :limit => 8
  end

  add_index "apply", ["from_user_id"], :name => "index_apply_on_from_user_id"
  add_index "apply", ["to_user_id"], :name => "index_apply_on_to_user_id"

  create_table "blocks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "blacklist_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "blocks", ["blacklist_id"], :name => "index_blocks_on_blacklist_id"
  add_index "blocks", ["user_id"], :name => "index_blocks_on_user_id"

  create_table "bulk_purchasing_order_details", :force => true do |t|
    t.integer "count", :default => 0
  end

  create_table "bulk_purchasings", :force => true do |t|
    t.integer  "dealer_id"
    t.integer  "location_id"
    t.integer  "rating_cache_id"
    t.integer  "area_id"
    t.string   "title"
    t.integer  "bulk_purchasing_type_id"
    t.datetime "expire_at"
    t.float    "price"
    t.float    "vip_price"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.float    "stars_average"
    t.float    "total_sale"
    t.integer  "orders_count",            :default => 0
    t.integer  "reviews_count",           :default => 0
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "bulk_purchasings", ["area_id"], :name => "index_bulk_purchasings_on_area_id"
  add_index "bulk_purchasings", ["bulk_purchasing_type_id"], :name => "index_bulk_purchasings_on_bulk_purchasing_type_id"
  add_index "bulk_purchasings", ["dealer_id"], :name => "index_bulk_purchasings_on_dealer_id"
  add_index "bulk_purchasings", ["location_id"], :name => "index_bulk_purchasings_on_location_id"
  add_index "bulk_purchasings", ["orders_count"], :name => "index_bulk_purchasings_on_orders_count"
  add_index "bulk_purchasings", ["price"], :name => "index_bulk_purchasings_on_price"
  add_index "bulk_purchasings", ["rating_cache_id"], :name => "index_bulk_purchasings_on_rating_cache_id"
  add_index "bulk_purchasings", ["reviews_count"], :name => "index_bulk_purchasings_on_reviews_count"
  add_index "bulk_purchasings", ["stars_average"], :name => "index_bulk_purchasings_on_stars_average"
  add_index "bulk_purchasings", ["total_sale"], :name => "index_bulk_purchasings_on_total_sale"
  add_index "bulk_purchasings", ["vip_price"], :name => "index_bulk_purchasings_on_vip_price"

  create_table "cleaning_order_details", :force => true do |t|
    t.integer "count",      :default => 0
    t.integer "used_count", :default => 0
  end

  create_table "cleanings", :force => true do |t|
    t.integer  "dealer_id"
    t.integer  "location_id"
    t.integer  "rating_cache_id"
    t.integer  "area_id"
    t.string   "title"
    t.integer  "cleaning_type_id"
    t.float    "price"
    t.float    "vip_price"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.float    "stars_average"
    t.float    "total_sale"
    t.integer  "orders_count",       :default => 0
    t.integer  "reviews_count",      :default => 0
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "cleanings", ["area_id"], :name => "index_cleanings_on_area_id"
  add_index "cleanings", ["cleaning_type_id"], :name => "index_cleanings_on_cleaning_type_id"
  add_index "cleanings", ["dealer_id"], :name => "index_cleanings_on_dealer_id"
  add_index "cleanings", ["location_id"], :name => "index_cleanings_on_location_id"
  add_index "cleanings", ["orders_count"], :name => "index_cleanings_on_orders_count"
  add_index "cleanings", ["price"], :name => "index_cleanings_on_price"
  add_index "cleanings", ["rating_cache_id"], :name => "index_cleanings_on_rating_cache_id"
  add_index "cleanings", ["reviews_count"], :name => "index_cleanings_on_reviews_count"
  add_index "cleanings", ["stars_average"], :name => "index_cleanings_on_stars_average"
  add_index "cleanings", ["total_sale"], :name => "index_cleanings_on_total_sale"
  add_index "cleanings", ["vip_price"], :name => "index_cleanings_on_vip_price"

  create_table "clubs", :force => true do |t|
    t.integer  "president_id"
    t.string   "mechanic_ids"
    t.string   "title"
    t.text     "announcement"
    t.integer  "area_id"
    t.integer  "brand_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "clubs", ["area_id", "brand_id"], :name => "index_clubs_on_area_id_and_brand_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "at_user_id"
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "dealer_details", :force => true do |t|
    t.integer  "location_id"
    t.integer  "area_id"
    t.integer  "dealer_type_id"
    t.string   "business_scope_ids"
    t.string   "company"
    t.string   "address"
    t.string   "phone"
    t.string   "open_during"
    t.integer  "balance",            :default => 0, :null => false
    t.string   "rqrcode_token"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "template_ids"
    t.integer  "balance_used",       :default => 0, :null => false
    t.float    "stars_average"
    t.float    "total_sale"
    t.integer  "orders_count",       :default => 0
    t.integer  "reviews_count",      :default => 0
  end

  add_index "dealer_details", ["area_id"], :name => "index_dealer_details_on_area_id"
  add_index "dealer_details", ["dealer_type_id"], :name => "index_dealer_details_on_dealer_type_id"
  add_index "dealer_details", ["location_id"], :name => "index_dealer_details_on_location_id"
  add_index "dealer_details", ["orders_count"], :name => "index_dealer_details_on_orders_count"
  add_index "dealer_details", ["reviews_count"], :name => "index_dealer_details_on_reviews_count"
  add_index "dealer_details", ["rqrcode_token"], :name => "index_dealer_details_on_rqrcode_token", :unique => true
  add_index "dealer_details", ["stars_average"], :name => "index_dealer_details_on_stars_average"
  add_index "dealer_details", ["total_sale"], :name => "index_dealer_details_on_total_sale"

  create_table "friend", :force => true do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.integer "created_at", :limit => 8
    t.integer "updated_at", :limit => 8
  end

  add_index "friend", ["friend_id"], :name => "index_friend_on_friend_id"
  add_index "friend", ["user_id"], :name => "index_friend_on_user_id"

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "locations", :force => true do |t|
    t.float  "latitude"
    t.float  "longitude"
    t.string "geohash"
  end

  add_index "locations", ["geohash"], :name => "index_locations_on_geohash"

  create_table "mending_order_details", :force => true do |t|
    t.integer  "brand_id"
    t.string   "series"
    t.string   "plate_num"
    t.datetime "arrive_at"
    t.integer  "mending_type_id"
    t.text     "description"
  end

  add_index "mending_order_details", ["brand_id"], :name => "index_mending_order_details_on_brand_id"
  add_index "mending_order_details", ["mending_type_id"], :name => "index_mending_order_details_on_mending_type_id"

  create_table "mendings", :force => true do |t|
    t.integer  "dealer_id"
    t.integer  "location_id"
    t.integer  "rating_cache_id"
    t.integer  "area_id"
    t.text     "discount"
    t.string   "brand_ids",       :limit => 1024
    t.text     "description"
    t.float    "stars_average"
    t.float    "total_sale"
    t.integer  "orders_count",                    :default => 0
    t.integer  "reviews_count",                   :default => 0
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "mendings", ["area_id"], :name => "index_mendings_on_area_id"
  add_index "mendings", ["dealer_id"], :name => "index_mendings_on_dealer_id"
  add_index "mendings", ["location_id"], :name => "index_mendings_on_location_id"
  add_index "mendings", ["orders_count"], :name => "index_mendings_on_orders_count"
  add_index "mendings", ["rating_cache_id"], :name => "index_mendings_on_rating_cache_id"
  add_index "mendings", ["reviews_count"], :name => "index_mendings_on_reviews_count"
  add_index "mendings", ["stars_average"], :name => "index_mendings_on_stars_average"
  add_index "mendings", ["total_sale"], :name => "index_mendings_on_total_sale"

  create_table "offline_message", :force => true do |t|
    t.integer "user_id"
    t.text    "content"
    t.integer "created_at", :limit => 8
  end

  add_index "offline_message", ["user_id"], :name => "index_offline_message_on_user_id"

  create_table "open_database_structs", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "open_database_structs", ["source_type", "source_id"], :name => "index_open_database_structs_on_source_type_and_source_id"
  add_index "open_database_structs", ["type", "id"], :name => "index_open_database_structs_on_type_and_id"

  create_table "orders", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.integer  "dealer_id"
    t.integer  "dealer_detail_id"
    t.integer  "detail_id"
    t.integer  "source_id"
    t.string   "title"
    t.integer  "state_id"
    t.float    "cost"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "orders", ["dealer_id"], :name => "index_orders_on_dealer_id"
  add_index "orders", ["detail_id"], :name => "index_orders_on_detail_id"
  add_index "orders", ["source_id"], :name => "index_orders_on_source_id"
  add_index "orders", ["state_id"], :name => "index_orders_on_state_id"
  add_index "orders", ["type", "id"], :name => "index_orders_on_type_and_id"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

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
    t.text     "content"
    t.integer  "view_count",         :default => 0
    t.integer  "comments_count",     :default => 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
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

  create_table "rating_caches", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reviews", :force => true do |t|
    t.integer  "order_id"
    t.text     "content"
    t.integer  "stars"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "reviews", ["order_id"], :name => "index_reviews_on_order_id"

  create_table "user_details", :force => true do |t|
    t.integer  "sex_id"
    t.integer  "area_id"
    t.integer  "brand_id"
    t.string   "series"
    t.string   "plate_num"
    t.integer  "balance",            :default => 0, :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.float    "total_spend"
    t.integer  "orders_count",       :default => 0
    t.integer  "posts_count",        :default => 0
  end

  add_index "user_details", ["area_id", "brand_id"], :name => "index_user_details_on_area_id_and_brand_id"
  add_index "user_details", ["orders_count"], :name => "index_user_details_on_orders_count"
  add_index "user_details", ["posts_count"], :name => "index_user_details_on_posts_count"
  add_index "user_details", ["total_spend"], :name => "index_user_details_on_total_spend"

  create_table "user_device", :force => true do |t|
    t.integer "user_id"
    t.string  "sys"
    t.string  "udid"
    t.string  "client_token"
    t.integer "created_at",   :limit => 8
    t.integer "updated_at",   :limit => 8
  end

  add_index "user_device", ["user_id"], :name => "index_user_device_on_user_id"

end
