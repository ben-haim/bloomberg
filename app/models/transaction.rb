class Transaction < ActiveRecord::Base
  attr_accessible :buy_sell, :num_shares, :portfolio_id, :price, :stock_id, :trans_date, :month, :year

  belongs_to :stock
  belongs_to :portfolio
end
