class AddMonthAndYearToPortfolioRecords < ActiveRecord::Migration
  def change
    add_column :portfolio_records, :month, :string
    add_column :portfolio_records, :year, :string

    add_index :portfolio_records, :month
    add_index :portfolio_records, :year
  end
end
