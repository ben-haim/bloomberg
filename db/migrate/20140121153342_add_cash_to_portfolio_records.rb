class AddCashToPortfolioRecords < ActiveRecord::Migration
  def change
    add_column :portfolio_records, :cash, :float
    remove_column :portfolios, :curr_cash 
  end
end
