class PortfoliosController < ApplicationController

	def show
		@portfolio = Portfolio.find(params[:id])
	end

	def preference
		@portfolio = Portfolio.first	# TODO make this flexible
		gon.portfolio = @portfolio
	end

	def make_transaction
		new_date = params[:date_year] + "-" + params[:date_month] + "-" + params[:date_day]
		symbol = params[:symbol].upcase

		# TODO execute the transaction
		if params[:buy_sell] == "buy"

		else

		end

		respond_to do |format|
			format.json { render json: { message: "hello" } }
		end
	end

	def send_alert
		user = User.find(params[:user_id].to_i)	# owner of the portfolio
		Notifier.send_alert_email(user).deliver

		# Twilio
		phone_number = user.phone
		twilio_sid = "AC187b60298ed3e4e63c415db16096fb60"
		twilio_token = "655b49db47d490b16f3777c2ea08e099"
		twilio_phone_number = "+12508002684"

		@twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

		@twilio_client.account.sms.messages.create(
			from: "#{twilio_phone_number}",
			to: "+16479978430",#phone_number,
			body: "This is a reminder that one of your metrics in your portfolio has exceeded your pre-defined threshold value."
			)

		respond_to do |format|
			format.json { render json: { message: "message successfully sent!" } }
		end
	end

	# Set the benchmark metrics preferences for the portfolio 
	def set_prefs
		portfolio = Portfolio.find(params[:portfolio_id].to_i)

		portfolio.curr_metric = params[:curr_metric]
		portfolio.sharpe_pref = params[:sharpe_pref]
		portfolio.alpha_pref = params[:alpha_pref]
		portfolio.beta_pref = params[:beta_pref]
		portfolio.capture_pref = params[:capture_pref]
		portfolio.treynor_pref = params[:treynor_pref]
		portfolio.corr_pref = params[:corr_pref]
		portfolio.r_2_pref = params[:r_2_pref]
		portfolio.var_pref = params[:var_pref]

		portfolio.save
		
		respond_to do |format|
			format.json { render json: { message: "Preferences saved." } }
		end
	end
end
