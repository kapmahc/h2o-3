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

ActiveRecord::Schema.define(version: 20170705175940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.string "content_type", limit: 255, null: false
    t.integer "length", null: false
    t.string "resource_type", limit: 255, null: false
    t.integer "resource_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar", null: false
    t.index ["content_type"], name: "index_attachments_on_content_type"
    t.index ["resource_type"], name: "index_attachments_on_resource_type"
    t.index ["title"], name: "index_attachments_on_title"
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
