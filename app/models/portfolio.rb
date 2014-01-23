class Portfolio < ActiveRecord::Base
	attr_accessible :name, :user_id, :alpha_pref, :beta_pref, :capture_pref, :sharpe_pref, :treynor_pref, :corr_pref, :r_2_pref, :var_pref, :start_cash

	has_many :holdings, dependent: :destroy
	#has_many :stocks, through: :holdings, dependent: :destroy

	has_many :portfolio_records		

	has_many :transactions

	belongs_to :user

	def update_metrics
		self.covariance
		self.alpha
		self.beta
		self.up_capture
		self.down_capture
		self.var

		self.capture_pref
		self.corr_pref
	end

	def alpha
	end

	def beta
	end

	def correlation_coeff
	end

	def covariance
	end

	def down_capture
	end

	def r_squared
	end

	def sharpe
	end

	def treynor_ratio
	end

	def up_capture
	end

	# Simple return on investment so far
	def roi
		(self.curr_cash.to_f - self.start_cash.to_f)/self.start_cash.to_f
	end

	# Aggregate the weighted return for each holding
	def three_month_return
		
	end

	def six_month_return
		
	end

	def one_year_return
			
	end

	# TODO How to calculate?
	def nbv
		self.holdings.where("holding = true")#.map { |h| [h.stock_id, h.holding, h.buy_price, h.sell_price, h.num_shares] }
	end

	def holding_weight(holding)
		holding.market_value / self.market_value
	end

	'''
	Ignore this code :)
	# Holdings at any given point in time			TODO replace with portfolio regeneration from all transactions
	def holdings_on(date)
		in_portfolio = []
		self.holdings.to_a.each do |holding|
			if holding.sell_date.nil? 
				if Metric.date_gt(date, holding.buy_date)
					in_portfolio << holding
				end
			else
				# before the holding was sold
				if Metric.date_gt(date, holding.buy_date) && Metric.date_gt(holding.sell_date, date)
					in_portfolio << holding
				end
			end
		end
		in_portfolio
	end

	# Calculate the holdings on a date, using checkpoints
	def holdings_on(date)
		# Get the latest holding in the portfolio (from the latest transactions)
		latest_holding = self.holdings.last #.order("updated_at DESC").limit(1)

		# holdings_start_of_month = closest_checkpoint_to(date)

		year = date.split("-")[0]
		month = date.split("-")[1]

		holdings_hash = Hash.new(0)		# store the final values

		# trans_since_check_point = Transaction.where("")

		trans_this_month = Transaction.where("month = ?", month)
		trans_this_month.each do |trans|
			if Metric.date_gt(date, trans.trans_date)
				# If the transaction comes before the given date
				curr_shares = holdings_hash[trans.stock_id]
				holdings_hash[trans.stock_id] += trans.num_shares
			end
		end

		# Add the checkpoint holdings to the holdings_hash 
		holdings_start_of_month.each do |holding|
			curr_shares = [holding.stock_id]
			holdings_hash[holding.stock_id] += holding.num_shares
		end

		holdings_hash
	end

	# Calculate the holdings on a date, using checkpoints
	def holdings_on(date)
		# Get all the holdings in the same month as the latest_holding_to_date.  Assuming that all previous holdings are updated whenever there is a new transaction in the month.
		holdings_in_the_month = self.latest_holdings_to_date

		trans_to_add = self.trans_until(date)		# all the transactions between the last holdings and the given date

		holdings_hash = Hash.new(0)		# aggregate transactions
		trans_to_add.each do |trans|
			if Metric.date_gt(date, trans.trans_date)
				curr_shares = holdings_hash[trans.stock_id]

				if trans.buy_sell == "buy"
					holdings_hash[trans.stock_id] += trans.num_shares
				else
					holdings_hash[trans.stock_id] -= trans.num_shares
				end
			end
		end

		holdings_in_the_month.each do |holding|		# add transactions to the holdings
			curr_shares = [holding.stock_id]
			holdings_hash[holding.stock_id] += holding.num_shares
		end

		holdings_hash
	end
	'''

	#PEI'S VERSION OF THIS 



	def get_returns_from(date1, date2, smp500)
		#for now, assume smp500 has the size of the number of days between date1 and date2 (including endpoints)
		current_holdings = holdings_on(date2)
		previous_holdings = holdings_on(date1)

		transactions = transactions_in_month_up_to(date2)
		transactions.sort_by{|e| e.trans_date.split('-').join('').to_i}

		portfolio_values =Array.new

		#for i in 0..(transactions.length-2)
		#	for j in 
		#end
	end

	# Buy the stock with symbol at the last close price of the date
	def buy(symbol, num_shares, date)
		stock = Stock.find_by_symbol(symbol)
		price = stock.get_price_on(date)
		self.transactions.build(num_shares: num_shares, trans_date: date, buy_sell: "buy", stock_id: stock.id, price: price, month: date.split("-")[1], year: date.split("-")[0])

-		new_cash = self.curr_cash - (num_shares * price.to_f)
		self.portfolio_records.build(cash: new_cash, date_record: date)

		self.save
	end

	def sell(symbol, num_shares, date)
		stock = Stock.find_by_symbol(symbol)
		price = stock.get_price_on(date)
		self.transactions.build(num_shares: num_shares, trans_date: date, buy_sell: "sell", stock_id: stock.id, price: price, month: date.split("-")[1], year: date.split("-")[0])

		new_cash = self.curr_cash + (num_shares * price.to_f)
		self.portfolio_records.build(cash: new_cash, date_record: date)

		self.save
	end

	def holdings_in_month(date)
		year = date.split("-")[0]
		month = date.split("-")[1]
		day = "01"
		as_of_date = year + "-" + month + "-" + day
		self.holdings.where("as_of_date = ?", as_of_date)
	end

	def transactions_in_month(date)
		year = date.split("-")[0]
		month = date.split("-")[1]

		self.transactions.where("year = ?", year).where("month = ?", month)
	end

	def transactions_in_month_up_to(date)
		month_transactions = transactions_in_month(date)
		transactions = Array.new

		month_transactions.each do |trans|
			if (Metric.date_gt(date, trans.trans_date))
				transactions.push(trans)
			end
		end
	end

	# Note: this should be updated as the   :as_of_date of the HOlding of NEXT MONTH!!
	def holdings_on(date)
		updated_holdings = Hash.new(0)		# includes processed transactions (transactions that have been processed ) and holdings

		transactions = transactions_in_month(date)
		transactions.each do |trans|
			if (Metric.date_gt(date, trans.trans_date))
				if trans.buy_sell == "buy"
					updated_holdings[trans.stock_id] += trans.num_shares
				else
					updated_holdings[trans.stock_id] -= trans.num_shares
				end
			end
		end

		holdings = holdings_in_month(date)	
		holdings.each do |holding|
			updated_holdings[holding.stock_id] += holding.num_shares
		end

		updated_holdings
	end

	# AFTER inserting all the buy/sell transactions to database, used to back-calculate the market values on previous days.  
	def update_holdings
		years = ["2012", "2013", "2014"]
		months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
		day = "01"

		# Go through each month
		years.each_with_index do |year, year_index|
			months.each_with_index do |month, month_index|
				holdings_on()
				'''
				if month == "01"	# We do not count the first month of 2012, since there is no previous month to it
					next if year == "2012"	
				
					prev_year = years[year_index-1]		
					prev_month = "12"
				else
					prev_year = year
					prev_month = months[month_index-1]
				end

				transactions = self.transactions.where("year = ?", year).where("month = ?", month)		# transactions of this month
				as_of_last_month = prev_year + "-" + prev_month + "-" + day 
				as_of_this_month = year + "-" + month + "-" + day 

				holdings_last_month = self.holdings.where("as_of_date = ?", as_of_last_month)		# Get holding from last month 
				
				# Holdings as of first day of this month = Holdings as of last month + all transactions from last month 
				holdings_this_month = []
				transactions.each do |trans|	
					bought = false				
					if trans.buy_sell == "buy"
						# see if we were holding this stock before.	If so, add to it
						holdings_last_month.each do |holding|
							if holding.stock_id == trans.stock_id 	
								num_shares = holding.num_shares + trans.num_shares
								holdings_this_month << [num_shares, holding.stock_id]
							bought = true						
							end
						end

						if bought == false
							holdings_this_month << [trans.num_shares, trans.stock_id]
						end
					else	# selling the stock 
						# see if we were holding this stock before.	If so, subtract from it.	If not, move on
						holdings_last_month.each do |holding|
							if holding.stock_id == trans.stock_id
								num_shares = holding.num_shares - trans.num_shares
								holdings_this_month << [num_shares, holding.stock_id]
							end
							# Not allowing short-selling for now
						end
					end
				end

				# Before saving, merge transactions of the same stocks into holdings
				holdings_hash = Hash.new(0)
				holdings_this_month.each do |num_shares, stock_id|
					curr_shares = holdings_hash[stock_id]
					holdings_hash[stock_id] += num_shares
				end

				holdings_hash.each do |combined_stock_id, combined_num_shares|
					self.holdings.build(num_shares: combined_num_shares, stock_id: combined_stock_id, as_of_date: as_of_this_month)	
					self.save
				end
			'''
			end
		end
	end

	# WE DON'T NEED THIS
	def latest_holding_to_date(date)
		res = nil

		# Find the latest holding before the given date
		self.holdings.each do |holding|
			if Metric.date_gt(date, holding.as_of_date)
				res = holding
			end
		end

		return res
	end

	# IMPORTANT: if we can assure that we have 
	# returns an array of transactions between the latest holding to date and the given date
	def trans_until(date)
		trans_to_add = []

		# If there has been no holdings to date, search for all transactions until we reach date
		latest_holding_to_date = self.latest_holding_to_date(date)
		if latest_holding_to_date.nil?
			self.transactions.each do |trans|
				break if Metric.date_gt(trans.trans_date, date)

				trans_to_add << trans
			end
		else 	# From the latest_holding, calculate all transactions.
			year = latest_holding_to_date.as_of_date.split("-")[0] 
			month = latest_holding_to_date.as_of_date.split("-")[1]

			first_transaction = self.transactions.where("year = ?", year).where("month = ?", month).first 

			if Metric.date_gt(date, first_transaction.trans_date)	
				# Get all the transactions since the first one, only if the first transaction hasn't passed the given date
				more_trans = self.transactions.where("id >= ?", first_transaction.id)
				more_trans.each do |trans|
					break if Metric.date_gt(trans.trans_date, date)

					trans_to_add << trans
				end
			end
		end
		trans_to_add
	end

	# Get all the holdings in the same month as the latest_holding_to_date.  Assuming that all previous holdings are updated whenever there is a new transaction in the month.
	def latest_holdings_to_date(date)
		latest_holding_to_date = self.latest_holding_to_date(date)
		if !latest_holding_to_date.nil?
			holdings_in_the_month = self.holdings.where("as_of_date = ?", latest_holding_to_date.as_of_date)
		else
			holdings_in_the_month = []
		end
	end

	# back-calculate market value of PORTFOLIO at any given point in time
	def market_value_on(date)
		holdings_hash = holdings_on(date)

		market_value = 0
		holdings_hash.each do |stock_id, num_shares|
			stock = Stock.find(stock_id)

			if !stock.nil?
				price = stock.get_price_on(date)
				market_value += price.to_f * num_shares.to_f
			end
		end

		market_value #+ cash_on(date)
	end

	# keep track of cash levels, with PortfolioRecord model.  the cash attr in PortfolioRecord should be updated after every transaction 
	def cash_on(date)
		year = date.split("-")[0]
		month = date.split("-")[1]
		
		# Inefficient method: iterate through all record until we have reached the date
		records = self.portfolio_records.where("cash > 0").order("updated_at ASC")

		curr_cash = self.start_cash
		records.each do |record|
			if Metric.date_gt(record.date_record, date)
				break
			end
			curr_cash = record.cash
		end

		return curr_cash	
	end

	# get the cash amount from the latest PortfolioRecord model 
	def curr_cash
		record = self.portfolio_records.where("cash > 0").order("updated_at DESC").first
		if record.nil?
			return self.start_cash
		else
			return record.cash
		end
	end

	def market_values
		
	end

	# Send the alert/notification email to the user
	def alert(user)
		Notifier.send_alert_email(user).deliver
	end
end