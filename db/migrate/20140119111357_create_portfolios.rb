class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :name
      t.integer :user_id
      t.float :covariance
      t.float :alpha
      t.float :beta
      t.float :sharpe
      t.float :up_capture
      t.float :down_capture
      t.float :correlation_coeff
      t.float :r_squared
      t.float :treynor_ratio

      t.timestamps
    end
  end
end
