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

ActiveRecord::Schema.define(version: 20170707200118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.string "content_type", limit: 255, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar", null: false
    t.index ["content_type"], name: "index_attachments_on_content_type"
    t.index ["title"], name: "index_attachments_on_title"
    t.index ["user_id"], name: "index_attachments_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "loc", limit: 16, null: false
    t.string "title", limit: 255, null: false
    t.string "summary", limit: 800, null: false
    t.string "format", limit: 12, null: false
    t.string "href", limit: 255, null: false
    t.string "logo", limit: 255, null: false
    t.string "action", limit: 32, null: false
    t.integer "sort_order", limit: 2, default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["format"], name: "index_cards_on_format"
    t.index ["loc"], name: "index_cards_on_loc"
  end

  create_table "forum_articles", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.text "body", null: false
    t.string "format", limit: 12, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["format"], name: "index_forum_articles_on_format"
    t.index ["title"], name: "index_forum_articles_on_title"
    t.index ["user_id"], name: "index_forum_articles_on_user_id"
  end

  create_table "forum_articles_tags", id: false, force: :cascade do |t|
    t.bigint "forum_article_id", null: false
    t.bigint "forum_tag_id", null: false
    t.index ["forum_article_id", "forum_tag_id"], name: "index_forum_articles_tags_on_forum_article_id_and_forum_tag_id", unique: true
    t.index ["forum_article_id"], name: "index_forum_articles_tags_on_forum_article_id"
    t.index ["forum_tag_id"], name: "index_forum_articles_tags_on_forum_tag_id"
  end

  create_table "forum_comments", force: :cascade do |t|
    t.text "body", null: false
    t.string "format", limit: 12, null: false
    t.bigint "forum_article_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["format"], name: "index_forum_comments_on_format"
    t.index ["forum_article_id"], name: "index_forum_comments_on_forum_article_id"
    t.index ["user_id"], name: "index_forum_comments_on_user_id"
  end

  create_table "forum_tags", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_forum_tags_on_name", unique: true
  end

  create_table "leave_words", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
  end

  create_table "mall_addresses", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.string "phone", limit: 16, null: false
    t.string "zip", limit: 8, null: false
    t.string "street", limit: 255, null: false
    t.string "city", limit: 32, null: false
    t.string "state", limit: 32, null: false
    t.string "country", limit: 32, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_mall_addresses_on_city"
    t.index ["country"], name: "index_mall_addresses_on_country"
    t.index ["name"], name: "index_mall_addresses_on_name"
    t.index ["phone"], name: "index_mall_addresses_on_phone"
    t.index ["state"], name: "index_mall_addresses_on_state"
    t.index ["user_id"], name: "index_mall_addresses_on_user_id"
    t.index ["zip"], name: "index_mall_addresses_on_zip"
  end

  create_table "mall_catalogs", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "format", limit: 12, null: false
    t.text "description", null: false
    t.text "assets"
    t.integer "sort_order", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["format"], name: "index_mall_catalogs_on_format"
    t.index ["name"], name: "index_mall_catalogs_on_name"
  end

  create_table "mall_charge_backs", force: :cascade do |t|
    t.string "state", limit: 16, null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "mall_return_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mall_return_request_id"], name: "index_mall_charge_backs_on_mall_return_request_id"
    t.index ["state"], name: "index_mall_charge_backs_on_state"
    t.index ["user_id"], name: "index_mall_charge_backs_on_user_id"
  end

  create_table "mall_logs", force: :cascade do |t|
    t.string "action", limit: 255, null: false
    t.integer "quantity", null: false
    t.bigint "user_id", null: false
    t.bigint "mall_variant_id", null: false
    t.bigint "mall_store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action"], name: "index_mall_logs_on_action"
    t.index ["mall_store_id"], name: "index_mall_logs_on_mall_store_id"
    t.index ["mall_variant_id"], name: "index_mall_logs_on_mall_variant_id"
    t.index ["user_id"], name: "index_mall_logs_on_user_id"
  end

  create_table "mall_orders", force: :cascade do |t|
    t.string "serial", limit: 255, null: false
    t.string "state", limit: 16, null: false
    t.string "shipment_state", limit: 16, null: false
    t.string "payment_state", limit: 16, null: false
    t.integer "total_cents", default: 0, null: false
    t.string "total_currency", default: "USD", null: false
    t.integer "items_total_cents", default: 0, null: false
    t.string "items_total_currency", default: "USD", null: false
    t.integer "adjustment_total_cents", default: 0, null: false
    t.string "adjustment_total_currency", default: "USD", null: false
    t.text "items", null: false
    t.string "address", null: false
    t.datetime "completed_at"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_mall_orders_on_address"
    t.index ["payment_state"], name: "index_mall_orders_on_payment_state"
    t.index ["serial"], name: "index_mall_orders_on_serial", unique: true
    t.index ["shipment_state"], name: "index_mall_orders_on_shipment_state"
    t.index ["state"], name: "index_mall_orders_on_state"
    t.index ["user_id"], name: "index_mall_orders_on_user_id"
  end

  create_table "mall_payment_methods", force: :cascade do |t|
    t.string "flag", limit: 16, null: false
    t.boolean "active", null: false
    t.string "name", limit: 255, null: false
    t.string "format", limit: 12, null: false
    t.text "description", null: false
    t.text "profile", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flag"], name: "index_mall_payment_methods_on_flag"
    t.index ["format"], name: "index_mall_payment_methods_on_format"
    t.index ["name"], name: "index_mall_payment_methods_on_name"
  end

  create_table "mall_payments", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.string "state", limit: 16, null: false
    t.string "response_code", limit: 3
    t.text "avs_response"
    t.bigint "mall_payment_method_id", null: false
    t.bigint "mall_order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mall_order_id"], name: "index_mall_payments_on_mall_order_id"
    t.index ["mall_payment_method_id"], name: "index_mall_payments_on_mall_payment_method_id"
    t.index ["response_code"], name: "index_mall_payments_on_response_code"
    t.index ["state"], name: "index_mall_payments_on_state"
  end

  create_table "mall_products", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "format", limit: 12, null: false
    t.text "description", null: false
    t.text "contact", null: false
    t.text "assets"
    t.text "fields"
    t.bigint "mall_store_id", null: false
    t.bigint "mall_vendor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["format"], name: "index_mall_products_on_format"
    t.index ["mall_store_id"], name: "index_mall_products_on_mall_store_id"
    t.index ["mall_vendor_id"], name: "index_mall_products_on_mall_vendor_id"
    t.index ["name"], name: "index_mall_products_on_name"
  end

  create_table "mall_return_requests", force: :cascade do |t|
    t.string "state", limit: 16, null: false
    t.text "reason", null: false
    t.text "items", null: false
    t.bigint "mall_order_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mall_order_id"], name: "index_mall_return_requests_on_mall_order_id"
    t.index ["state"], name: "index_mall_return_requests_on_state"
    t.index ["user_id"], name: "index_mall_return_requests_on_user_id"
  end

  create_table "mall_shipments", force: :cascade do |t|
    t.string "state", limit: 16, null: false
    t.integer "cost_cents", default: 0, null: false
    t.string "cost_currency", default: "USD", null: false
    t.string "serial", limit: 255, null: false
    t.datetime "shipped_at"
    t.bigint "mall_shipment_method_id", null: false
    t.bigint "mall_order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mall_order_id"], name: "index_mall_shipments_on_mall_order_id"
    t.index ["mall_shipment_method_id"], name: "index_mall_shipments_on_mall_shipment_method_id"
    t.index ["state"], name: "index_mall_shipments_on_state"
  end

  create_table "mall_shipping_methods", force: :cascade do |t|
    t.boolean "active", null: false
    t.string "tracking", limit: 255
    t.string "name", limit: 255, null: false
    t.string "format", limit: 12, null: false
    t.text "description", null: false
    t.text "profile", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["format"], name: "index_mall_shipping_methods_on_format"
    t.index ["name"], name: "index_mall_shipping_methods_on_name"
  end

  create_table "mall_stocks", force: :cascade do |t|
    t.integer "quantity", null: false
    t.bigint "mall_variant_id", null: false
    t.bigint "mall_store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mall_store_id", "mall_variant_id"], name: "index_mall_stocks_on_mall_store_id_and_mall_variant_id", unique: true
    t.index ["mall_store_id"], name: "index_mall_stocks_on_mall_store_id"
    t.index ["mall_variant_id"], name: "index_mall_stocks_on_mall_variant_id"
  end

  create_table "mall_stores", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "format", limit: 12, null: false
    t.string "currency", limit: 3, null: false
    t.text "description", null: false
    t.text "contact", null: false
    t.text "assets"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency"], name: "index_mall_stores_on_currency"
    t.index ["format"], name: "index_mall_stores_on_format"
    t.index ["name"], name: "index_mall_stores_on_name"
  end

  create_table "mall_variants", force: :cascade do |t|
    t.string "sku", limit: 255, null: false
    t.string "state", limit: 16, null: false
    t.string "name", limit: 255, null: false
    t.string "format", limit: 12, null: false
    t.text "description", null: false
    t.text "assets"
    t.text "fields"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.integer "cost_cents", default: 0, null: false
    t.string "cost_currency", default: "USD", null: false
    t.bigint "mall_product_id", null: false
    t.bigint "mall_store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["format"], name: "index_mall_variants_on_format"
    t.index ["mall_product_id"], name: "index_mall_variants_on_mall_product_id"
    t.index ["mall_store_id"], name: "index_mall_variants_on_mall_store_id"
    t.index ["name"], name: "index_mall_variants_on_name"
    t.index ["sku", "mall_store_id"], name: "index_mall_variants_on_sku_and_mall_store_id", unique: true
  end

  create_table "mall_vendors", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "format", limit: 12, null: false
    t.text "description", null: false
    t.text "assets"
    t.text "fields"
    t.bigint "mall_store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["format"], name: "index_mall_vendors_on_format"
    t.index ["mall_store_id"], name: "index_mall_vendors_on_mall_store_id"
    t.index ["name"], name: "index_mall_vendors_on_name"
  end

  create_table "pos_orders", force: :cascade do |t|
    t.string "serial", limit: 255, null: false
    t.text "items", null: false
    t.text "flag", null: false
    t.text "description", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.integer "payment_cents", default: 0, null: false
    t.string "payment_currency", default: "USD", null: false
    t.integer "charge_back_cents", default: 0, null: false
    t.string "charge_back_currency", default: "USD", null: false
    t.integer "discount_cents", default: 0, null: false
    t.string "discount_currency", default: "USD", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flag"], name: "index_pos_orders_on_flag"
    t.index ["serial"], name: "index_pos_orders_on_serial", unique: true
    t.index ["user_id"], name: "index_pos_orders_on_user_id"
  end

  create_table "pos_returns", force: :cascade do |t|
    t.text "flag", null: false
    t.text "items", null: false
    t.text "description", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.bigint "user_id", null: false
    t.bigint "pos_order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flag"], name: "index_pos_returns_on_flag"
    t.index ["pos_order_id"], name: "index_pos_returns_on_pos_order_id"
    t.index ["user_id"], name: "index_pos_returns_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.integer "thing_id"
    t.string "thing_type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true
  end

  create_table "survey_fields", force: :cascade do |t|
    t.string "name", limit: 16, null: false
    t.string "label", limit: 255, null: false
    t.string "flag", limit: 12, null: false
    t.string "value", limit: 255
    t.string "help", limit: 800
    t.text "options"
    t.integer "sort_order", limit: 2, null: false
    t.bigint "survey_form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "survey_form_id"], name: "index_survey_fields_on_name_and_survey_form_id", unique: true
    t.index ["name"], name: "index_survey_fields_on_name"
    t.index ["survey_form_id"], name: "index_survey_fields_on_survey_form_id"
  end

  create_table "survey_forms", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.text "body", null: false
    t.string "format", limit: 12, null: false
    t.date "start_up", null: false
    t.date "shut_down", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["format"], name: "index_survey_forms_on_format"
    t.index ["title"], name: "index_survey_forms_on_title"
  end

  create_table "survey_records", force: :cascade do |t|
    t.inet "client_ip", null: false
    t.text "value", null: false
    t.bigint "survey_form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_form_id"], name: "index_survey_records_on_survey_form_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "votes", force: :cascade do |t|
    t.string "resource_type", limit: 255, null: false
    t.integer "resource_id", null: false
    t.integer "mark", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_type", "resource_id"], name: "index_votes_on_resource_type_and_resource_id", unique: true
    t.index ["resource_type"], name: "index_votes_on_resource_type"
  end

end
