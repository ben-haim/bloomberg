class AddCurrentMetricToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :curr_metric, :string
  end
end
