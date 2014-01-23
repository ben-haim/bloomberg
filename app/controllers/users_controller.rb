class UsersController < ApplicationController

	def index
		@users = User.all		
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		
	end

	def update
		
	end
end
