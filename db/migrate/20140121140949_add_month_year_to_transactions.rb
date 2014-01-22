class AddMonthYearToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :month, :string
    add_column :transactions, :year, :string

    add_index :transactions, :month
    add_index :transactions, :year
  end
end
