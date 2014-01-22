class AddHoldingToHoldings < ActiveRecord::Migration
  def change
    add_column :holdings, :holding, :boolean
  end
end
