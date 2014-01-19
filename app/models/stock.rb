class Stock < ActiveRecord::Base
  attr_accessible :symbol

  has_many :holdings
  has_many :portfolios, through: :holdings
end