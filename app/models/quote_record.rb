class QuoteRecord < ActiveRecord::Base
  attr_accessible :price, :record_time, :stock_id, :stock_return, :symbol
end
