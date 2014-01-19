class AddPreferencesToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :sharpe_pref, :float
    add_column :portfolios, :alpha_pref, :float
    add_column :portfolios, :beta_pref, :float
    add_column :portfolios, :capture_pref, :float
    add_column :portfolios, :corr_pref, :float
    add_column :portfolios, :r_2_pref, :float
    add_column :portfolios, :var_pref, :float
  end
end
