class Holding < ActiveRecord::Base
  attr_accessible :num_stocks, :portfolio_id, :stock_id

  belongs_to :portfolio
  belongs_to :stock
end
