class CreateQuoteRecords < ActiveRecord::Migration
  def change
    create_table :quote_records do |t|
      t.string :record_time
      t.integer :stock_id
      t.string :symbol
      t.float :price
      t.float :stock_return

      t.timestamps
    end
  end
end
