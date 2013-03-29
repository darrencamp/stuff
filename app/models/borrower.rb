class Borrower < ActiveRecord::Base
  has_many :loans
  belongs_to :user
  
  validates_uniqueness_of :email, :scope => :user_id
  validates_presence_of :user, :item
end