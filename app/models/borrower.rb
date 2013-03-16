class Borrower < ActiveRecord::Base
  has_many :loans
  belongs_to :user
end