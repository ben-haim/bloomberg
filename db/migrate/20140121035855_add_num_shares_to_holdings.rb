class AddNumSharesToHoldings < ActiveRecord::Migration
  def change
    add_column :holdings, :num_shares, :integer

    add_column :portfolios, :treynor_pref, :float
  end
end
