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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140527051456) do

  create_table "accounts", force: true do |t|
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_mobile"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "detail_id"
    t.string   "username",               default: "",    null: false
    t.string   "mobile",                 default: "",    null: false
    t.text     "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "accepted_at"
    t.integer  "sex_id"
    t.integer  "area_id"
    t.integer  "brand_id"
    t.integer  "friends_count",          default: 0
    t.integer  "posts_count",            default: 0
    t.integer  "orders_count",           default: 0
    t.integer  "reviews_count",          default: 0
    t.integer  "stars_count",            default: 0
    t.integer  "total_cost",             default: 0
    t.integer  "location_id"
    t.integer  "position",               default: 0
    t.boolean  "display",                default: false
    t.integer  "rank_id",                default: 1
    t.string   "weixin_token"
  end

  add_index "accounts", ["accepted_at"], name: "index_accounts_on_accepted_at", using: :btree
  add_index "accounts", ["area_id", "brand_id"], name: "index_accounts_on_area_id_and_brand_id", using: :btree
  add_index "accounts", ["authentication_token"], name: "index_accounts_on_authentication_token", unique: true, using: :btree
  add_index "accounts", ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true, using: :btree
  add_index "accounts", ["detail_id"], name: "index_accounts_on_detail_id", using: :btree
  add_index "accounts", ["display"], name: "index_accounts_on_display", using: :btree
  add_index "accounts", ["friends_count"], name: "index_accounts_on_friends_count", using: :btree
  add_index "accounts", ["location_id"], name: "index_accounts_on_location_id", using: :btree
  add_index "accounts", ["mobile"], name: "index_accounts_on_mobile", using: :btree
  add_index "accounts", ["orders_count"], name: "index_accounts_on_orders_count", using: :btree
  add_index "accounts", ["position"], name: "index_accounts_on_position", using: :btree
  add_index "accounts", ["posts_count"], name: "index_accounts_on_posts_count", using: :btree
  add_index "accounts", ["rank_id"], name: "index_accounts_on_rank_id", using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree
  add_index "accounts", ["reviews_count"], name: "index_accounts_on_reviews_count", using: :btree
  add_index "accounts", ["stars_count"], name: "index_accounts_on_stars_count", using: :btree
  add_index "accounts", ["total_cost"], name: "index_accounts_on_total_cost", using: :btree
  add_index "accounts", ["type", "id"], name: "index_accounts_on_type_and_id", using: :btree
  add_index "accounts", ["unlock_token"], name: "index_accounts_on_unlock_token", unique: true, using: :btree
  add_index "accounts", ["username"], name: "index_accounts_on_username", using: :btree

  create_table "accounts_ad_templates", force: true do |t|
    t.integer "distributor_id"
    t.integer "ad_template_id"
  end

  create_table "accounts_clubs", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "club_id"
  end

  create_table "activities", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",           default: 0
    t.boolean  "display",            default: true
  end

  add_index "activities", ["area_id"], name: "index_activities_on_area_id", using: :btree
  add_index "activities", ["dealer_id"], name: "index_activities_on_dealer_id", using: :btree
  add_index "activities", ["display"], name: "index_activities_on_display", using: :btree
  add_index "activities", ["expire_at"], name: "index_activities_on_expire_at", using: :btree
  add_index "activities", ["location_id"], name: "index_activities_on_location_id", using: :btree
  add_index "activities", ["position"], name: "index_activities_on_position", using: :btree

  create_table "ad_templates", force: true do |t|
    t.string   "title"
    t.float    "price",               default: 0.0
    t.integer  "product_id"
    t.integer  "product_type_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ad_templates", ["product_id"], name: "index_ad_templates_on_product_id", using: :btree
  add_index "ad_templates", ["product_type_id"], name: "index_ad_templates_on_product_type_id", using: :btree

  create_table "adverts", force: true do |t|
    t.integer  "advert_type_id"
    t.integer  "area_id"
    t.integer  "brand_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "adverts", ["advert_type_id"], name: "index_adverts_on_advert_type_id", using: :btree
  add_index "adverts", ["area_id"], name: "index_adverts_on_area_id", using: :btree
  add_index "adverts", ["brand_id"], name: "index_adverts_on_brand_id", using: :btree

  create_table "apply", force: true do |t|
    t.integer "from_user_id"
    t.integer "to_user_id"
    t.text    "content"
    t.integer "created_at",   limit: 8
  end

  add_index "apply", ["from_user_id"], name: "index_apply_on_from_user_id", using: :btree
  add_index "apply", ["to_user_id"], name: "index_apply_on_to_user_id", using: :btree

  create_table "blacklist", force: true do |t|
    t.integer "user_id"
    t.integer "blacklist_id"
    t.integer "created_at",   limit: 8
    t.integer "updated_at",   limit: 8
  end

  add_index "blacklist", ["blacklist_id"], name: "index_blacklist_on_blacklist_id", using: :btree
  add_index "blacklist", ["user_id"], name: "index_blacklist_on_user_id", using: :btree

  create_table "blocks", force: true do |t|
    t.integer  "user_id"
    t.integer  "blacklist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blocks", ["blacklist_id"], name: "index_blocks_on_blacklist_id", using: :btree
  add_index "blocks", ["user_id"], name: "index_blocks_on_user_id", using: :btree

  create_table "brands", force: true do |t|
    t.string "name"
  end

  add_index "brands", ["name"], name: "index_brands_on_name", using: :btree

  create_table "bulk_purchasing2_orders", force: true do |t|
    t.integer  "dealer_id"
    t.integer  "distributor_id"
    t.integer  "source_id"
    t.string   "title"
    t.integer  "state_id",       default: 1
    t.float    "cost"
    t.integer  "count",          default: 0
    t.integer  "used_count",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bulk_purchasing2_orders", ["dealer_id"], name: "index_bulk_purchasing2_orders_on_dealer_id", using: :btree
  add_index "bulk_purchasing2_orders", ["distributor_id"], name: "index_bulk_purchasing2_orders_on_distributor_id", using: :btree
  add_index "bulk_purchasing2_orders", ["source_id"], name: "index_bulk_purchasing2_orders_on_source_id", using: :btree
  add_index "bulk_purchasing2_orders", ["state_id"], name: "index_bulk_purchasing2_orders_on_state_id", using: :btree

  create_table "bulk_purchasing2s", force: true do |t|
    t.integer  "distributor_id"
    t.integer  "location_id"
    t.integer  "area_id"
    t.string   "title"
    t.integer  "bulk_purchasing_type_id"
    t.datetime "expire_at"
    t.float    "price"
    t.float    "vip_price"
    t.integer  "inventory"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.float    "total_cost"
    t.integer  "orders_count",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bulk_purchasing2s", ["area_id"], name: "index_bulk_purchasing2s_on_area_id", using: :btree
  add_index "bulk_purchasing2s", ["bulk_purchasing_type_id"], name: "index_bulk_purchasing2s_on_bulk_purchasing_type_id", using: :btree
  add_index "bulk_purchasing2s", ["distributor_id"], name: "index_bulk_purchasing2s_on_distributor_id", using: :btree
  add_index "bulk_purchasing2s", ["expire_at"], name: "index_bulk_purchasing2s_on_expire_at", using: :btree
  add_index "bulk_purchasing2s", ["location_id"], name: "index_bulk_purchasing2s_on_location_id", using: :btree
  add_index "bulk_purchasing2s", ["orders_count"], name: "index_bulk_purchasing2s_on_orders_count", using: :btree
  add_index "bulk_purchasing2s", ["price"], name: "index_bulk_purchasing2s_on_price", using: :btree
  add_index "bulk_purchasing2s", ["total_cost"], name: "index_bulk_purchasing2s_on_total_cost", using: :btree
  add_index "bulk_purchasing2s", ["vip_price"], name: "index_bulk_purchasing2s_on_vip_price", using: :btree

  create_table "bulk_purchasings", force: true do |t|
    t.integer  "dealer_id"
    t.integer  "location_id"
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
    t.float    "total_cost"
    t.integer  "orders_count",            default: 0
    t.integer  "reviews_count",           default: 0
    t.integer  "stars_count",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",                default: 0
    t.boolean  "display",                 default: true
  end

  add_index "bulk_purchasings", ["area_id"], name: "index_bulk_purchasings_on_area_id", using: :btree
  add_index "bulk_purchasings", ["bulk_purchasing_type_id"], name: "index_bulk_purchasings_on_bulk_purchasing_type_id", using: :btree
  add_index "bulk_purchasings", ["dealer_id"], name: "index_bulk_purchasings_on_dealer_id", using: :btree
  add_index "bulk_purchasings", ["display"], name: "index_bulk_purchasings_on_display", using: :btree
  add_index "bulk_purchasings", ["expire_at"], name: "index_bulk_purchasings_on_expire_at", using: :btree
  add_index "bulk_purchasings", ["location_id"], name: "index_bulk_purchasings_on_location_id", using: :btree
  add_index "bulk_purchasings", ["orders_count"], name: "index_bulk_purchasings_on_orders_count", using: :btree
  add_index "bulk_purchasings", ["position"], name: "index_bulk_purchasings_on_position", using: :btree
  add_index "bulk_purchasings", ["price"], name: "index_bulk_purchasings_on_price", using: :btree
  add_index "bulk_purchasings", ["reviews_count"], name: "index_bulk_purchasings_on_reviews_count", using: :btree
  add_index "bulk_purchasings", ["stars_count"], name: "index_bulk_purchasings_on_stars_count", using: :btree
  add_index "bulk_purchasings", ["total_cost"], name: "index_bulk_purchasings_on_total_cost", using: :btree
  add_index "bulk_purchasings", ["vip_price"], name: "index_bulk_purchasings_on_vip_price", using: :btree

  create_table "cleanings", force: true do |t|
    t.integer  "dealer_id"
    t.integer  "location_id"
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
    t.float    "total_cost"
    t.integer  "orders_count",       default: 0
    t.integer  "reviews_count",      default: 0
    t.integer  "stars_count",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",           default: 0
    t.boolean  "display",            default: true
  end

  add_index "cleanings", ["area_id"], name: "index_cleanings_on_area_id", using: :btree
  add_index "cleanings", ["cleaning_type_id"], name: "index_cleanings_on_cleaning_type_id", using: :btree
  add_index "cleanings", ["dealer_id"], name: "index_cleanings_on_dealer_id", using: :btree
  add_index "cleanings", ["display"], name: "index_cleanings_on_display", using: :btree
  add_index "cleanings", ["location_id"], name: "index_cleanings_on_location_id", using: :btree
  add_index "cleanings", ["orders_count"], name: "index_cleanings_on_orders_count", using: :btree
  add_index "cleanings", ["position"], name: "index_cleanings_on_position", using: :btree
  add_index "cleanings", ["price"], name: "index_cleanings_on_price", using: :btree
  add_index "cleanings", ["reviews_count"], name: "index_cleanings_on_reviews_count", using: :btree
  add_index "cleanings", ["stars_count"], name: "index_cleanings_on_stars_count", using: :btree
  add_index "cleanings", ["total_cost"], name: "index_cleanings_on_total_cost", using: :btree
  add_index "cleanings", ["vip_price"], name: "index_cleanings_on_vip_price", using: :btree

  create_table "client_versions", force: true do |t|
    t.integer  "client_type_id"
    t.integer  "version"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "clubs", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clubs", ["area_id", "brand_id"], name: "index_clubs_on_area_id_and_brand_id", using: :btree

  create_table "comments", force: true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.integer  "at_user_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_username"
    t.string   "at_user_username"
  end

  add_index "comments", ["source_type", "source_id"], name: "index_comments_on_source_type_and_source_id", using: :btree
  add_index "comments", ["type", "id"], name: "index_comments_on_type_and_id", using: :btree

  create_table "construction_cases", force: true do |t|
    t.integer  "distributor_id"
    t.integer  "dealer_id"
    t.string   "title"
    t.integer  "product_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "construction_cases", ["dealer_id"], name: "index_construction_cases_on_dealer_id", using: :btree
  add_index "construction_cases", ["distributor_id"], name: "index_construction_cases_on_distributor_id", using: :btree

  create_table "consumption_records", force: true do |t|
    t.integer  "user_id"
    t.integer  "dealer_id"
    t.integer  "order_id"
    t.string   "order_type"
    t.string   "title"
    t.integer  "count",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consumption_records", ["dealer_id"], name: "index_consumption_records_on_dealer_id", using: :btree
  add_index "consumption_records", ["order_id", "order_type"], name: "index_consumption_records_on_order_id_and_order_type", using: :btree
  add_index "consumption_records", ["user_id"], name: "index_consumption_records_on_user_id", using: :btree

  create_table "dealer_details", force: true do |t|
    t.integer  "dealer_type_id"
    t.integer  "specific_service_id"
    t.string   "business_scope_ids"
    t.string   "company"
    t.string   "address"
    t.string   "phone"
    t.string   "open_during"
    t.integer  "balance",                    default: 0, null: false
    t.string   "rqrcode_token"
    t.string   "rqrcode_image_file_name"
    t.string   "rqrcode_image_content_type"
    t.integer  "rqrcode_image_file_size"
    t.datetime "rqrcode_image_updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "template_ids"
    t.integer  "balance_used",               default: 0, null: false
    t.string   "rescue_phone"
    t.string   "insurance_phone"
    t.string   "secondhand_appraise_phone"
    t.string   "postsale_phone"
    t.string   "weixin_app_id"
    t.string   "weixin_app_secret"
    t.text     "weixin_welcome"
    t.string   "test_drive_phone"
  end

  add_index "dealer_details", ["dealer_type_id"], name: "index_dealer_details_on_dealer_type_id", using: :btree
  add_index "dealer_details", ["rqrcode_token"], name: "index_dealer_details_on_rqrcode_token", using: :btree
  add_index "dealer_details", ["specific_service_id"], name: "index_dealer_details_on_specific_service_id", using: :btree

  create_table "distributor_details", force: true do |t|
    t.integer  "distributor_type_id"
    t.string   "business_scope_ids"
    t.string   "product_ids"
    t.string   "brand_ids"
    t.string   "company"
    t.string   "address"
    t.string   "phone"
    t.string   "rqrcode_token"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "rqrcode_image_file_name"
    t.string   "rqrcode_image_content_type"
    t.integer  "rqrcode_image_file_size"
    t.datetime "rqrcode_image_updated_at"
    t.string   "weixin_app_id"
    t.string   "weixin_app_secret"
    t.text     "weixin_welcome"
  end

  add_index "distributor_details", ["distributor_type_id"], name: "index_distributor_details_on_distributor_type_id", using: :btree

  create_table "distributor_infos", force: true do |t|
    t.integer "tutorial_id"
    t.string  "company"
    t.string  "address"
    t.string  "phone"
  end

  create_table "distributor_infos_tutorials", id: false, force: true do |t|
    t.integer "tutorial_id",         null: false
    t.integer "distributor_info_id", null: false
  end

  create_table "exposures", force: true do |t|
    t.integer  "user_id"
    t.integer  "at_user_id"
    t.integer  "provider_id"
    t.text     "content"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exposures", ["provider_id"], name: "index_exposures_on_provider_id", using: :btree

  create_table "friend", force: true do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.integer "created_at", limit: 8
    t.integer "updated_at", limit: 8
  end

  add_index "friend", ["friend_id"], name: "index_friend_on_friend_id", using: :btree
  add_index "friend", ["user_id"], name: "index_friend_on_user_id", using: :btree

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id", using: :btree

  create_table "hosts", force: true do |t|
    t.integer  "provider_id"
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hosts", ["provider_id"], name: "index_hosts_on_provider_id", using: :btree

  create_table "hosts_programmes", id: false, force: true do |t|
    t.integer "host_id"
    t.integer "programme_id"
  end

  add_index "hosts_programmes", ["host_id"], name: "index_hosts_programmes_on_host_id", using: :btree
  add_index "hosts_programmes", ["programme_id"], name: "index_hosts_programmes_on_programme_id", using: :btree

  create_table "locations", force: true do |t|
    t.float  "latitude"
    t.float  "longitude"
    t.string "geohash"
  end

  add_index "locations", ["geohash"], name: "index_locations_on_geohash", using: :btree

  create_table "manual_images", force: true do |t|
    t.integer  "distributor_id"
    t.string   "title"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "category"
  end

  add_index "manual_images", ["distributor_id"], name: "index_manual_images_on_distributor_id", using: :btree

  create_table "mending_order_details", force: true do |t|
    t.integer  "brand_id"
    t.string   "series"
    t.string   "plate_num"
    t.datetime "arrive_at"
    t.integer  "mending_type_id"
    t.text     "description"
    t.boolean  "notified",        default: false
  end

  add_index "mending_order_details", ["brand_id"], name: "index_mending_order_details_on_brand_id", using: :btree
  add_index "mending_order_details", ["mending_type_id"], name: "index_mending_order_details_on_mending_type_id", using: :btree

  create_table "mendings", force: true do |t|
    t.integer  "dealer_id"
    t.integer  "location_id"
    t.integer  "area_id"
    t.text     "discount"
    t.string   "brand_ids"
    t.text     "description"
    t.float    "total_cost"
    t.integer  "orders_count",   default: 0
    t.integer  "reviews_count",  default: 0
    t.integer  "stars_count",    default: 0
    t.text     "total_costs"
    t.text     "orders_counts"
    t.text     "reviews_counts"
    t.text     "stars_counts"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",       default: 0
    t.boolean  "display",        default: true
  end

  add_index "mendings", ["area_id"], name: "index_mendings_on_area_id", using: :btree
  add_index "mendings", ["dealer_id"], name: "index_mendings_on_dealer_id", using: :btree
  add_index "mendings", ["display"], name: "index_mendings_on_display", using: :btree
  add_index "mendings", ["location_id"], name: "index_mendings_on_location_id", using: :btree
  add_index "mendings", ["orders_count"], name: "index_mendings_on_orders_count", using: :btree
  add_index "mendings", ["position"], name: "index_mendings_on_position", using: :btree
  add_index "mendings", ["reviews_count"], name: "index_mendings_on_reviews_count", using: :btree
  add_index "mendings", ["stars_count"], name: "index_mendings_on_stars_count", using: :btree
  add_index "mendings", ["total_cost"], name: "index_mendings_on_total_cost", using: :btree

  create_table "offline_message", force: true do |t|
    t.integer "user_id"
    t.text    "content"
    t.integer "created_at", limit: 8
  end

  add_index "offline_message", ["user_id"], name: "index_offline_message_on_user_id", using: :btree

  create_table "open_database_structs", force: true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "open_database_structs", ["source_type", "source_id"], name: "index_open_database_structs_on_source_type_and_source_id", using: :btree
  add_index "open_database_structs", ["type", "id"], name: "index_open_database_structs_on_type_and_id", using: :btree

  create_table "operating_records", force: true do |t|
    t.integer  "user_id"
    t.integer  "dealer_id"
    t.string   "user_brand"
    t.string   "project"
    t.string   "operator"
    t.string   "inspector"
    t.string   "adviser"
    t.string   "user_mobile"
    t.string   "user_plate_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "operating_records", ["dealer_id"], name: "index_operating_records_on_dealer_id", using: :btree
  add_index "operating_records", ["user_id"], name: "index_operating_records_on_user_id", using: :btree
  add_index "operating_records", ["user_mobile"], name: "index_operating_records_on_user_mobile", using: :btree
  add_index "operating_records", ["user_plate_num"], name: "index_operating_records_on_user_plate_num", using: :btree

  create_table "orders", force: true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.integer  "dealer_id"
    t.integer  "detail_id"
    t.integer  "source_id"
    t.string   "title"
    t.integer  "state_id",        default: 1
    t.float    "cost",            default: 0.0
    t.integer  "count",           default: 0
    t.integer  "used_count",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_mobile"
    t.string   "user_plate_num"
    t.integer  "dealer_state_id", default: 1
  end

  add_index "orders", ["dealer_id"], name: "index_orders_on_dealer_id", using: :btree
  add_index "orders", ["detail_id"], name: "index_orders_on_detail_id", using: :btree
  add_index "orders", ["source_id"], name: "index_orders_on_source_id", using: :btree
  add_index "orders", ["state_id"], name: "index_orders_on_state_id", using: :btree
  add_index "orders", ["type", "id"], name: "index_orders_on_type_and_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree
  add_index "orders", ["user_mobile"], name: "index_orders_on_user_mobile", using: :btree
  add_index "orders", ["user_plate_num"], name: "index_orders_on_user_plate_num", using: :btree

  create_table "post_blocks", force: true do |t|
    t.integer  "user_id"
    t.integer  "blacklist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_blocks", ["blacklist_id"], name: "index_post_blocks_on_blacklist_id", using: :btree
  add_index "post_blocks", ["user_id"], name: "index_post_blocks_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.integer  "area_id"
    t.integer  "brand_id"
    t.text     "content"
    t.integer  "comments_count",        default: 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_username"
    t.string   "user_description"
    t.string   "user_avatar_thumb_url"
  end

  add_index "posts", ["area_id", "brand_id"], name: "index_posts_on_area_id_and_brand_id", using: :btree
  add_index "posts", ["comments_count"], name: "index_posts_on_comments_count", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "products", force: true do |t|
    t.string "name"
  end

  add_index "products", ["name"], name: "index_products_on_name", using: :btree

  create_table "programme_lists", force: true do |t|
    t.integer  "provider_id"
    t.string   "airdate"
    t.string   "title"
    t.text     "description"
    t.string   "day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "programme_lists", ["provider_id"], name: "index_programme_lists_on_provider_id", using: :btree

  create_table "programmes", force: true do |t|
    t.integer  "provider_id"
    t.string   "title"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "programmes", ["provider_id"], name: "index_programmes_on_provider_id", using: :btree

  create_table "provider_details", force: true do |t|
    t.string   "company"
    t.string   "phone"
    t.string   "template_ids"
    t.string   "rqrcode_token"
    t.string   "rqrcode_image_file_name"
    t.string   "rqrcode_image_content_type"
    t.integer  "rqrcode_image_file_size"
    t.datetime "rqrcode_image_updated_at"
  end

  add_index "provider_details", ["rqrcode_token"], name: "index_provider_details_on_rqrcode_token", using: :btree

  create_table "purchase_requestings", force: true do |t|
    t.integer  "dealer_id"
    t.string   "title"
    t.datetime "expire_at"
    t.integer  "purchase_requesting_type_id"
    t.integer  "area_id"
    t.string   "price_range"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "order_id"
    t.text     "content"
    t.integer  "stars",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["order_id"], name: "index_reviews_on_order_id", using: :btree

  create_table "sales_cases", force: true do |t|
    t.integer  "user_id"
    t.integer  "dealer_id"
    t.text     "description"
    t.string   "adviser"
    t.string   "user_mobile"
    t.string   "user_plate_num"
    t.integer  "state_id",       default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "sales_cases", ["dealer_id"], name: "index_sales_cases_on_dealer_id", using: :btree
  add_index "sales_cases", ["state_id"], name: "index_sales_cases_on_state_id", using: :btree
  add_index "sales_cases", ["user_id"], name: "index_sales_cases_on_user_id", using: :btree
  add_index "sales_cases", ["user_mobile"], name: "index_sales_cases_on_user_mobile", using: :btree
  add_index "sales_cases", ["user_plate_num"], name: "index_sales_cases_on_user_plate_num", using: :btree

  create_table "secondhand_appraise_order_details", force: true do |t|
    t.integer  "brand_id"
    t.string   "series"
    t.string   "plate_num"
    t.text     "description"
    t.datetime "purchasing_date"
    t.integer  "travelling_miles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "secondhand_appraise_order_details", ["brand_id"], name: "index_secondhand_appraise_order_details_on_brand_id", using: :btree

  create_table "test_drivings", force: true do |t|
    t.integer  "dealer_id"
    t.string   "title"
    t.float    "price"
    t.text     "params"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "orders_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "brand_id"
    t.string   "series"
    t.text     "description"
  end

  add_index "test_drivings", ["brand_id"], name: "index_test_drivings_on_brand_id", using: :btree
  add_index "test_drivings", ["dealer_id"], name: "index_test_drivings_on_dealer_id", using: :btree
  add_index "test_drivings", ["series"], name: "index_test_drivings_on_series", using: :btree

  create_table "traffic_reports", force: true do |t|
    t.integer  "user_id"
    t.integer  "at_user_id"
    t.integer  "provider_id"
    t.text     "content"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "geohash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "traffic_reports", ["geohash"], name: "index_traffic_reports_on_geohash", using: :btree
  add_index "traffic_reports", ["provider_id"], name: "index_traffic_reports_on_provider_id", using: :btree

  create_table "tutorials", force: true do |t|
    t.string   "title"
    t.integer  "product_id"
    t.integer  "product_type_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "url",                 limit: 1023
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tutorials", ["product_id"], name: "index_tutorials_on_product_id", using: :btree
  add_index "tutorials", ["product_type_id"], name: "index_tutorials_on_product_type_id", using: :btree

  create_table "uploads", force: true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "type_id"
  end

  add_index "uploads", ["type_id"], name: "index_uploads_on_type_id", using: :btree

  create_table "user_details", force: true do |t|
    t.string   "series"
    t.string   "plate_num"
    t.integer  "balance",            default: 0, null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "user_device", force: true do |t|
    t.integer "user_id"
    t.string  "sys"
    t.string  "udid"
    t.string  "client_token"
    t.integer "created_at",   limit: 8
    t.integer "updated_at",   limit: 8
  end

  add_index "user_device", ["user_id"], name: "index_user_device_on_user_id", using: :btree

  create_table "vehicle_insurance_order_details", force: true do |t|
    t.integer "brand_id"
    t.string  "series"
    t.string  "plate_num"
    t.text    "description"
    t.string  "insurance_type_ids"
  end

  add_index "vehicle_insurance_order_details", ["brand_id"], name: "index_vehicle_insurance_order_details_on_brand_id", using: :btree

  create_table "vip_card_items", force: true do |t|
    t.integer "vip_card_id"
    t.string  "title"
    t.float   "price"
    t.integer "count"
  end

  add_index "vip_card_items", ["price"], name: "index_vip_card_items_on_price", using: :btree
  add_index "vip_card_items", ["vip_card_id"], name: "index_vip_card_items_on_vip_card_id", using: :btree

  create_table "vip_card_order_items", force: true do |t|
    t.integer "vip_card_order_id"
    t.integer "source_id"
    t.string  "title"
    t.integer "state_id",          default: 1
    t.float   "cost"
    t.integer "count",             default: 0
    t.integer "used_count",        default: 0
    t.boolean "has_review",        default: false
  end

  add_index "vip_card_order_items", ["state_id"], name: "index_vip_card_order_items_on_state_id", using: :btree

  create_table "vip_cards", force: true do |t|
    t.integer  "dealer_id"
    t.integer  "location_id"
    t.integer  "area_id"
    t.string   "title"
    t.float    "price"
    t.float    "vip_price"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "position",           default: 0
    t.boolean  "display",            default: true
    t.float    "total_cost"
    t.integer  "orders_count",       default: 0
    t.integer  "reviews_count",      default: 0
    t.integer  "stars_count",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vip_cards", ["area_id"], name: "index_vip_cards_on_area_id", using: :btree
  add_index "vip_cards", ["dealer_id"], name: "index_vip_cards_on_dealer_id", using: :btree
  add_index "vip_cards", ["display"], name: "index_vip_cards_on_display", using: :btree
  add_index "vip_cards", ["location_id"], name: "index_vip_cards_on_location_id", using: :btree
  add_index "vip_cards", ["orders_count"], name: "index_vip_cards_on_orders_count", using: :btree
  add_index "vip_cards", ["position"], name: "index_vip_cards_on_position", using: :btree
  add_index "vip_cards", ["price"], name: "index_vip_cards_on_price", using: :btree
  add_index "vip_cards", ["reviews_count"], name: "index_vip_cards_on_reviews_count", using: :btree
  add_index "vip_cards", ["stars_count"], name: "index_vip_cards_on_stars_count", using: :btree
  add_index "vip_cards", ["vip_price"], name: "index_vip_cards_on_vip_price", using: :btree

end
