class Item < ActiveRecord::Base
  attr_accessible :name, :description
  belongs_to :user
  
  validates_uniqueness_of :name, :scope => :user_id
  validates_presence_of :user 
end
