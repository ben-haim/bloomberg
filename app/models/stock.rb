require 'open-uri'

class Stock < ActiveRecord::Base
  attr_accessible :symbol, :curr_price, :date_updated

  has_many :holdings
  #has_many :portfolios, through: :holdings

  has_many :transactions

  # NOTE: only run this method once
  '''
  def self.init_stocks
  	symbols_list_url = "https://s3-us-west-2.amazonaws.com/bloombergrisk/sp500.txt"
	f = open(symbols_list_url).read().split("\n")

	f.each do |line|
		Stock.create(symbol: line, curr_price: 0, date_updated: "2014-01-20")
	end
  end
  '''

  def self.test_cron
  	Stock.create(symbol: "test", curr_price: 0, date_updated: "2014-01-20")
  end

  def self.update_prices
  	symbols_list_url = "https://s3-us-west-2.amazonaws.com/bloombergrisk/sp500.txt"
	f = open(symbols_list_url).read().split("\n")

	f.each do |symbol|
		symbol = symbol.strip
		if (symbol.split(".").length == 1)
			s3_dir = "https://s3-us-west-2.amazonaws.com/bloombergrisk/historical_data/SP500/" 
			data_file_name = s3_dir.concat(symbol).concat("+US+Equity_data.txt")

			# Open the price data of the stock		
			puts symbol + "\n"

			stock_data = open(data_file_name).read().split("\n")
			last_day = stock_data[-1]

			stock = Stock.find_by_symbol(symbol)
			stock.date_updated = last_day.split(",")[0]
			stock.curr_price = last_day.split(",")[1].to_f
			stock.save
		end
	end
  end

  # S&P500 as benchmark
  def self.update_benchmarks
  	url = "https://s3-us-west-2.amazonaws.com/bloombergrisk/historical_data/benchmarks/sp500_data.txt"
  	data = open(url).read().split("\n")[-1]

	benchmark = Stock.find_by_symbol("spx")
	benchmark.date_updated = data.split(",")[0]
	benchmark.curr_price = data.split(",")[1].strip.to_f
	benchmark.save
  end

  # US 10 Year T-Bill as risk free
  def self.update_risk_free
  	url = "https://s3-us-west-2.amazonaws.com/bloombergrisk/historical_data/risk_free/us_tbill_data.txt"
  	data = open(url).read().split("\n")[-1]

	risk_free = Stock.find_by_symbol("us_tbill")
	risk_free.date_updated = data.split(",")[0]
	risk_free.curr_price = data.split(",")[1].strip.to_f
	risk_free.save
  end

  # Given a date in string, output the price
  def get_price_on(date)
  	url = "https://s3-us-west-2.amazonaws.com/bloombergrisk/historical_data/SP500/" + self.symbol + "+US+Equity_data.txt"
  	f = open(url).read().split("\n")

  	i = 0
  	f.each do |line|
  		data_date = line.split(",")[0]
  		price = line.split(",")[1].strip.to_f

  		if date == data_date
  			return price
  		end

  		# If we have already passed the date
  		if Metric.date_gt(data_date, date)
  			break
  		end

  		i += 1
  	end

  	# Get the closest price
  	closest = f[i]
  	return closest.split(",")[1].strip.to_f
  end
end