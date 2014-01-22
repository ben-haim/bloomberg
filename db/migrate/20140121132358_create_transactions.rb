class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :buy_sell
      t.integer :portfolio_id
      t.integer :stock_id
      t.integer :num_shares
      t.float :price

      t.timestamps
    end
  end
end
