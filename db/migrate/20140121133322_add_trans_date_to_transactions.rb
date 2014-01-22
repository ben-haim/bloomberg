class AddTransDateToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :trans_date, :string
  end
end
