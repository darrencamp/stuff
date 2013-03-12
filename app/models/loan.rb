class Loan < ActiveRecord::Base
  belongs_to :user
  belongs_to :borrower
  belongs_to :item
  
  attr_accessor :item_name
end
