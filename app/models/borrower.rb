class Borrower < ActiveRecord::Base
  has_many :loans
end