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

ActiveRecord::Schema.define(:version => 20140119135021) do

  create_table "holdings", :force => true do |t|
    t.integer  "portfolio_id"
    t.integer  "stock_id"
    t.integer  "num_stocks"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "portfolio_records", :force => true do |t|
    t.integer  "portfolio_id"
    t.string   "date_record"
    t.float    "ret"
    t.float    "arith_mean"
    t.float    "geo_mean"
    t.float    "std_dev"
    t.float    "covar"
    t.float    "alpha"
    t.float    "beta"
    t.float    "sharpe"
    t.float    "up_capture"
    t.float    "down_capture"
    t.float    "corr_coeff"
    t.float    "r_squared"
    t.float    "treynor"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "portfolios", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.float    "covariance"
    t.float    "alpha"
    t.float    "beta"
    t.float    "sharpe"
    t.float    "up_capture"
    t.float    "down_capture"
    t.float    "correlation_coeff"
    t.float    "r_squared"
    t.float    "treynor_ratio"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.float    "sharpe_pref"
    t.float    "alpha_pref"
    t.float    "beta_pref"
    t.float    "capture_pref"
    t.float    "corr_pref"
    t.float    "r_2_pref"
    t.float    "var_pref"
  end

  create_table "quote_records", :force => true do |t|
    t.string   "record_time"
    t.integer  "stock_id"
    t.string   "symbol"
    t.float    "price"
    t.float    "stock_return"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "stocks", :force => true do |t|
    t.string   "symbol"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
