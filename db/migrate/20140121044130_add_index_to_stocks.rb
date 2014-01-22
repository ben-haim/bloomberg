class AddIndexToStocks < ActiveRecord::Migration
  def change
  	add_index :stocks, :symbol
  end
end
