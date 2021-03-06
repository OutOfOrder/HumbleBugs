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

ActiveRecord::Schema.define(:version => 20150214222155) do

  create_table "bundles", :force => true do |t|
    t.string   "name"
    t.datetime "target_date"
    t.text     "description"
    t.string   "state"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "bundles", ["state"], :name => "index_bundles_on_state"

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.integer  "author_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["author_id"], :name => "index_notes_on_owner_id"
  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_notes_on_noteable_id_and_noteable_type"

  create_table "developers", :force => true do |t|
    t.string   "name",                :null => false
    t.string   "website"
    t.string   "time_zone"
    t.text     "address"
    t.text     "contact_information"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "developers", ["name"], :name => "index_developers_on_name", :unique => true

  create_table "games", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "bundle_id"
    t.string   "state"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "developer_id"
  end

  add_index "games", ["bundle_id"], :name => "index_games_on_bundle_id"
  add_index "games", ["developer_id"], :name => "index_games_on_developer_id"

  create_table "issues", :force => true do |t|
    t.integer  "game_id"
    t.text     "description"
    t.string   "status"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "reported_against_id"
    t.integer  "fixed_in_id"
    t.integer  "author_id"
    t.string   "summary"
    t.integer  "priority",            :default => 50, :null => false
  end

  add_index "issues", ["author_id"], :name => "index_issues_on_author_id"
  add_index "issues", ["fixed_in_id"], :name => "index_issues_on_fixed_in_id"
  add_index "issues", ["game_id"], :name => "index_issues_on_game_id"
  add_index "issues", ["priority"], :name => "index_issues_on_priority", :order => {"priority"=>:desc}
  add_index "issues", ["reported_against_id"], :name => "index_issues_on_reported_against_id"

  create_table "ports", :force => true do |t|
    t.integer  "game_id"
    t.string   "state"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "developer_id"
  end

  add_index "ports", ["developer_id"], :name => "index_ports_on_developer_id"
  add_index "ports", ["game_id"], :name => "index_ports_on_game_id"

  create_table "predefined_tags", :force => true do |t|
    t.string   "name"
    t.string   "context",    :limit => 128
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "predefined_tags", ["context", "name"], :name => "index_predefined_tags_on_context_and_name", :unique => true

  create_table "releases", :force => true do |t|
    t.integer  "game_id"
    t.text     "notes"
    t.integer  "owner_id"
    t.string   "url"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "download_count", :default => 0,        :null => false
    t.string   "version",                              :null => false
    t.string   "checksum"
    t.string   "status",         :default => "active", :null => false
  end

  add_index "releases", ["game_id"], :name => "index_releases_on_game_id"
  add_index "releases", ["owner_id"], :name => "index_releases_on_owner_id"

  create_table "systems", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.string   "name",             :null => false
    t.text     "description"
    t.string   "operating_system"
    t.string   "processor"
    t.string   "graphics_card"
    t.string   "graphics_driver"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "systems", ["user_id"], :name => "index_systems_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], :name => "taggings_idx", :unique => true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "taggings_count", :default => 0
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "test_results", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "system_id",  :null => false
    t.integer  "release_id", :null => false
    t.string   "rating",     :null => false
    t.text     "comments"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "test_results", ["release_id", "system_id"], :name => "index_test_results_on_release_id_and_system_id", :unique => true
  add_index "test_results", ["system_id"], :name => "index_test_results_on_system_id"
  add_index "test_results", ["user_id"], :name => "index_test_results_on_user_id"

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "role",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_roles", ["role"], :name => "index_user_roles_on_role"
  add_index "user_roles", ["user_id", "role"], :name => "index_user_roles_on_user_id_and_role", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "time_zone"
    t.string   "confirm_account_token"
    t.datetime "confirm_account_sent_at"
    t.datetime "nda_signed_date"
    t.integer  "developer_id"
    t.text     "dashboard"
  end

  add_index "users", ["auth_token"], :name => "index_users_on_auth_token", :unique => true
  add_index "users", ["confirm_account_token"], :name => "index_users_on_confirm_account_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["nda_signed_date"], :name => "index_users_on_nda_signed_date"
  add_index "users", ["password_reset_token"], :name => "index_users_on_password_reset_token", :unique => true

end
