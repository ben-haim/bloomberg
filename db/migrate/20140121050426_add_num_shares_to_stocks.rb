class AddNumSharesToStocks < ActiveRecord::Migration
  def change
    #add_column :holdings, :num_shares, :integer
    remove_column :holdings, :num_stocks 
  end
end
