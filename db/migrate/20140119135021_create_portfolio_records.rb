class CreatePortfolioRecords < ActiveRecord::Migration
  def change
    create_table :portfolio_records do |t|
      t.integer :portfolio_id
      t.string :date_record
      t.float :ret
      t.float :arith_mean
      t.float :geo_mean
      t.float :std_dev
      t.float :covar
      t.float :alpha
      t.float :beta
      t.float :sharpe
      t.float :up_capture
      t.float :down_capture
      t.float :corr_coeff
      t.float :r_squared
      t.float :treynor

      t.timestamps
    end
  end
end
