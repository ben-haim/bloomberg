class AddStartingAndCurrCashToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :start_cash, :float
    add_column :portfolios, :curr_cash, :float
  end
end
