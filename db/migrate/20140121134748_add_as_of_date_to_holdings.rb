class AddAsOfDateToHoldings < ActiveRecord::Migration
  def change
    add_column :holdings, :as_of_date, :string
    add_index :holdings, :as_of_date
  end
end