class PortfolioRecord < ActiveRecord::Base
  attr_accessible :alpha, :arith_mean, :beta, :corr_coeff, :covar, :date_record, :down_capture, :geo_mean, :r_squared, :ret, :sharpe, :std_dev, :treynor, :up_capture

  belongs_to :portfolio
end
