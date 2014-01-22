class ModifyStockAndHoldingModels < ActiveRecord::Migration
  def up
  	add_column :holdings, :buy_date, :string
  	add_column :holdings, :sell_date, :string
  	add_column :holdings, :buy_price, :float
  	add_column :holdings, :sell_price, :float

  	add_column :stocks, :curr_price, :float
  	add_column :stocks, :date_updated, :string
  end

  def down
  end
end
