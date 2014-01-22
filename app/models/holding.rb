class Holding < ActiveRecord::Base
  attr_accessible :num_stocks, :portfolio_id, :stock_id, :num_shares, :buy_price, :buy_date, :sell_price, :sell_date, :holding, :as_of_date

  belongs_to :portfolio
  belongs_to :stock

  def market_value
  	stock = self.stock
  	self.num_shares * stock.curr_price
  end

  def portfolio_holdings
  	
  end
end