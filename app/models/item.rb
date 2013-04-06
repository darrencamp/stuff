class Item < ActiveRecord::Base
  attr_accessible :name, :description, :tag_list
  belongs_to :user

  acts_as_taggable
  
  validates_uniqueness_of :name, :scope => :user_id
  validates_presence_of :user 
end
