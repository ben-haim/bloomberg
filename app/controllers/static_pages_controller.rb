class StaticPagesController < ApplicationController
	
	def home
		@user = User.new
	end

	def preference
		@portfolio = Portfolio.first
	end
end
