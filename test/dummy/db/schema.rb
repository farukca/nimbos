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

ActiveRecord::Schema.define(:version => 20130810194053) do

  create_table "nimbos_activities", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.string   "target_type", :limit => 40
    t.integer  "target_id"
    t.string   "target_name", :limit => 60
    t.integer  "patron_id",                 :null => false
    t.integer  "branch_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "nimbos_activities", ["user_id", "patron_id"], :name => "index_nimbos_activities_on_user_id_and_patron_id"

  create_table "nimbos_branches", :force => true do |t|
    t.string   "name",       :limit => 40,                        :null => false
    t.string   "tel",        :limit => 15
    t.string   "fax",        :limit => 15
    t.string   "email",      :limit => 40
    t.string   "postcode",   :limit => 5
    t.string   "address",    :limit => 80
    t.string   "district",   :limit => 40
    t.string   "city",       :limit => 100
    t.string   "state",      :limit => 100
    t.string   "country_id", :limit => 2
    t.string   "status",     :limit => 10,  :default => "active"
    t.integer  "patron_id",                                       :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  add_index "nimbos_branches", ["patron_id"], :name => "index_nimbos_branches_on_patron_id"

  create_table "nimbos_comments", :force => true do |t|
    t.integer  "user_id",                                         :null => false
    t.text     "comment_text",                                    :null => false
    t.string   "commentable_type", :limit => 40
    t.integer  "commentable_id"
    t.string   "commenter",        :limit => 1,  :default => "U"
    t.integer  "patron_id",                                       :null => false
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  create_table "nimbos_countries", :primary_key => "code", :force => true do |t|
    t.string   "name",          :limit => 40,                    :null => false
    t.string   "telcode",       :limit => 10
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "locale",        :limit => 20
    t.string   "language",      :limit => 10
    t.string   "time_zone"
    t.string   "mail_encoding", :limit => 20
    t.string   "domain",        :limit => 10
    t.string   "code3",         :limit => 3
    t.string   "currency",      :limit => 20
    t.string   "region",        :limit => 100
    t.string   "subregion",     :limit => 100
    t.boolean  "listable",                     :default => true
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  create_table "nimbos_listheaders", :force => true do |t|
    t.string   "code",        :null => false
    t.string   "name"
    t.string   "i18n_code"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "nimbos_listitems", :force => true do |t|
    t.string   "code",          :limit => 50, :null => false
    t.string   "name",          :limit => 50
    t.string   "list_code"
    t.string   "i18n_code"
    t.integer  "listheader_id",               :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "nimbos_patrons", :force => true do |t|
    t.string   "name",            :limit => 40,                        :null => false
    t.string   "title",           :limit => 60
    t.string   "email",           :limit => 60,                        :null => false
    t.string   "website",         :limit => 60
    t.string   "tel",             :limit => 20
    t.string   "fax",             :limit => 20
    t.string   "gsm",             :limit => 20
    t.string   "postcode",        :limit => 5
    t.string   "address",         :limit => 60
    t.string   "contact_name",    :limit => 40
    t.string   "contact_surname", :limit => 40
    t.string   "city",            :limit => 100
    t.string   "state",           :limit => 100
    t.string   "country_id",      :limit => 2
    t.string   "patron_type",     :limit => 20
    t.string   "employees",       :limit => 10
    t.string   "language",        :limit => 2
    t.string   "status",          :limit => 10,  :default => "active"
    t.string   "logo"
    t.string   "patron_token",    :limit => 40
    t.string   "time_zone",       :limit => 30
    t.string   "district",        :limit => 40
    t.string   "currency",        :limit => 10
    t.string   "locale",          :limit => 20
    t.string   "mail_encoding",   :limit => 20
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  create_table "nimbos_posts", :force => true do |t|
    t.integer  "user_id",                                      :null => false
    t.text     "message",                                      :null => false
    t.string   "target_type", :limit => 40
    t.integer  "target_id"
    t.string   "target_name", :limit => 40
    t.string   "post_type",   :limit => 20
    t.boolean  "is_private",                :default => false
    t.boolean  "is_syspost",                :default => false
    t.integer  "patron_id",                                    :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "nimbos_users", :force => true do |t|
    t.string   "email",                           :limit => 40,                                           :null => false
    t.string   "password_digest"
    t.string   "salt"
    t.string   "name",                            :limit => 40
    t.string   "surname",                         :limit => 40
    t.integer  "patron_id"
    t.string   "patron_key",                      :limit => 20
    t.string   "language",                                      :default => "en"
    t.string   "time_zone",                                     :default => "Eastern Time (US & Canada)"
    t.string   "locale",                          :limit => 8
    t.string   "region",                          :limit => 2
    t.string   "user_type",                       :limit => 2
    t.string   "mail_encoding",                   :limit => 20
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_email_time"
    t.datetime "password_reset_token_expires_at"
    t.integer  "failed_logins_count"
    t.integer  "lock_expires_at"
    t.string   "role"
    t.string   "avatar"
    t.integer  "branch_id",                                     :default => 0,                            :null => false
    t.string   "remember_me_token"
    t.string   "remember_me_token_expires_at"
    t.string   "datetime"
    t.boolean  "firstuser",                                     :default => false
    t.string   "user_status",                     :limit => 10, :default => "active"
    t.datetime "created_at",                                                                              :null => false
    t.datetime "updated_at",                                                                              :null => false
  end

  add_index "nimbos_users", ["email"], :name => "index_nimbos_users_on_email", :unique => true
  add_index "nimbos_users", ["patron_id"], :name => "index_nimbos_users_on_patron_id"
  add_index "nimbos_users", ["remember_me_token"], :name => "index_nimbos_users_on_remember_me_token"

end
