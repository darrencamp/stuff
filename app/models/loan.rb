class Loan < ActiveRecord::Base
  belongs_to :user
  belongs_to :borrower
end
