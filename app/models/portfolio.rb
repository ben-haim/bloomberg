class Portfolio < ActiveRecord::Base
  attr_accessible :alpha, :beta, :correlation_coeff, :covariance, :down_capture, :name, :r_squared, :sharpe, :treynor_ratio, :up_capture, :user_id

  has_many :holdings
  has_many :stocks, through: :holdings

  has_many :portfolio_records
end
