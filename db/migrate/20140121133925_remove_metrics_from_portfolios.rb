class RemoveMetricsFromPortfolios < ActiveRecord::Migration
  def up
  	remove_column :portfolios, :alpha
  	remove_column :portfolios, :beta
  	remove_column :portfolios, :correlation_coeff
  	remove_column :portfolios, :covariance
  	remove_column :portfolios, :down_capture
  	remove_column :portfolios, :r_squared
  	remove_column :portfolios, :sharpe
  	remove_column :portfolios, :treynor_ratio
  	remove_column :portfolios, :up_capture
  end

  def down
  end
end
