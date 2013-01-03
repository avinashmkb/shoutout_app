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

ActiveRecord::Schema.define(:version => 20121228095128) do

  create_table "aiaioo_failures", :force => true do |t|
    t.string   "source_number"
    t.string   "text"
    t.integer  "retried"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "branches", :force => true do |t|
    t.string   "address_lane1"
    t.string   "address_lane2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contact_number"
  end

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "login_id"
    t.string   "hashed_password"
    t.string   "salt"
    t.boolean  "sms_alerts"
    t.string   "unicel_vnumber"
    t.boolean  "mcoupon"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "created_by"
    t.integer  "business_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "category_keywords", :force => true do |t|
    t.string   "keyword"
    t.string   "created_by"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "configtables", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "business_id"
  end

  create_table "custom_messages", :force => true do |t|
    t.string   "message"
    t.string   "created_by"
    t.integer  "sentiment_id"
    t.integer  "branch_id"
    t.integer  "business_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "fbusers", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "feedback_categories", :force => true do |t|
    t.integer  "feedback_id"
    t.integer  "category_id"
    t.integer  "branch_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "feedback_topics", :force => true do |t|
    t.integer  "feedback_id"
    t.integer  "trendingtopic_id"
    t.integer  "branch_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "message"
    t.integer  "user_id"
    t.integer  "sentiment_id"
    t.integer  "branch_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "sentiment_score"
    t.string   "ref_num"
  end

  create_table "incoming_message_logs", :force => true do |t|
    t.string   "message"
    t.string   "mobile_number"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "keywords", :force => true do |t|
    t.string   "keyword"
    t.string   "mobile_number"
    t.integer  "business_id"
    t.integer  "branch_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "mcoupons", :force => true do |t|
    t.string   "coupon_id"
    t.string   "coupon_code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "status"
    t.integer  "business_id"
  end

  create_table "offers", :force => true do |t|
    t.string   "message"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "created_by"
    t.integer  "sentiment_id"
    t.integer  "branch_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "outgoing_message_logs", :force => true do |t|
    t.string   "message"
    t.string   "destination_mobile_number"
    t.string   "message_status"
    t.integer  "user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "play_evolutions", :force => true do |t|
    t.string   "hash",          :null => false
    t.datetime "applied_at",    :null => false
    t.text     "apply_script"
    t.text     "revert_script"
    t.string   "state"
    t.text     "last_problem"
  end

  create_table "sentiment_overrides", :force => true do |t|
    t.string   "text"
    t.string   "sentiment_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "sentiments", :force => true do |t|
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sms_lingos", :force => true do |t|
    t.string   "sms_word"
    t.string   "english_text"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "smsalert_checks", :force => true do |t|
    t.string   "allowed_keyword"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "trending_topics", :force => true do |t|
    t.string   "text"
    t.integer  "sentiment_id"
    t.integer  "branch_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "sentiment_score"
  end

  create_table "users", :force => true do |t|
    t.string   "mobile_number"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
