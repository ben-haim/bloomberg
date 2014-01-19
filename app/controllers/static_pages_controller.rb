class StaticPagesController < ApplicationController
	def preference
		@portfolio = Portfolio.first
	end
end
