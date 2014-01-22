class Metric 

	def self.home
		portfolio = [0.24, 0.4, 0.01, 0.12, 0.33, 0.21, 0.02]
		benchmark = [0.14, -0.3, 0.001, 0.02, 0.55, 0.11, 0.02]
		risk_free = [0.12, 0.12, 0.02, 0.01, 0.24, 0.07, 0.011]
		market = [0.33, 0.22, 0.023, 0.22, 0.23, 0.14, 0.212]
		raw_values = [234.3, 221.2, 244.5, 233.1, 215.9, 222.2, 233.5, 293.2]
		dividends = [0,0,0,0,0,0,0]

		@returns = calc_returns(raw_values)
	end

	def self.calc_returns(prices)
	  	returns = Array.new
	  	prices.each_index do |index|
	  		if index != prices.length - 1
	  			returns.push((prices[index + 1] - prices[index])/prices[index])
	  		end
	  	end
	  	return returns
	end

	def self.roi(start_price, curr_price)
		(curr_price.to_f - start_price.to_f)/start_price.to_f
	end

	def self.arithmetic_mean(returns)
	  	sum = 0
	  	returns.each do |return_value|
	  		sum += return_value
	  	end

	  	return sum/returns.length
	end

	def self.geometric_mean(returns) 
	  	product = 1
	  	returns.each do |return_value|
	  		product *= (1 + return_value)
	  	end

	  	return product^(1/returns.length)
	end

	def self.standard_deviation(returns)
	  	sum = 0
	  	average = arithmetic_mean(returns)

	  	returns.each do |return_value|
	  		sum += (return_value - average)^2
	  	end

	  	return (sum/(returns.length-1))^0.5
	end

	def self.covariance(portfolio, benchmark)
	  	average_portfolio = arithmetic_mean(portfolio)
	  	average_benchmark = arithmetic_mean(benchmark)
	  	sum = 0

	  	portfolio.each_index do |index|
	  		sum += (portfolio[index] - average_portfolio)*(benchmark[index] - average_benchmark)
	  	end

	  	return sum/(portfolio.length - 1)
	end

	def self.beta(portfolio, benchmark)
	  	return covariance(portfolio, benchmark)/standard_deviation(benchmark)^2
	end

	def self.alpha(portfolio, benchmark, risk_free)
	  	return arithmetic_mean(portfolio) - (arithmetic_mean(risk_free) + beta(portfolio) * (arithmetic_mean(benchmark) - arithmetic_mean(risk_free)));
	end

	def self.sharpe(portfolio, risk_free)
	  	return (arithmetic_mean(portfolio) - arithmetic_mean(risk_free))/standard_deviation(portfolio);
	end

	def self.up_capture(portfolio, benchmark)
	  	sum_portfolio = 0;
		sum_benchmark = 0;

		portfolio.each_index do |index|
			if benchmark[index] > 0
				sum_portfolio += portfolio[index]
				sum_benchmark += benchmark[index]
			end
		end 

		return sum_portfolio/sum_benchmark
	end

	def self.down_capture(portfolio, benchmark)
	  	sum_portfolio = 0;
		sum_benchmark = 0;

		portfolio.each_index do |index|
			if benchmark[index] < 0
				sum_portfolio += portfolio[index]
				sum_benchmark += benchmark[index]
			end
		end 

		return sum_portfolio/sum_benchmark
	end

	def self.correlation_coefficient(portfolio, benchmark)
		return covariance(portfolio, benchmark)/(standard_deviation(portfolio) * standard_deviation(benchmark));
	end

	def self.r_squared(portfolio, benchmark) 
		return (beta(portfolio, benchmark)^2 * standard_deviation(benchmark)^2)/standard_deviation(portfolio)
	end

	def self.treynor_ratio(portfolio, risk_free) 
		return (arithmetic_mean(portfolio) - arithmetic_mean(risk_free))/beta(portfolio, risk_free);
	end

	# compare two string dates, return true if date1 > date2
	def self.date_gt(date1, date2)
	  	date1 = date1.split("-")
	  	date2 = date2.split("-")

	  	dt1 = DateTime.new(date1[0].to_i, date1[1].to_i, date1[2].to_i)
	  	dt2 = DateTime.new(date2[0].to_i, date2[1].to_i, date2[2].to_i)

	  	dt1 > dt2
	end
	
end