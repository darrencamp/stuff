class Item < ActiveRecord::Base
#  attr_accessible :name, :description, :tag_list
  belongs_to :user
  belongs_to :bucket

  acts_as_taggable
  
  validates_uniqueness_of :name, :scope => :user_id
  validates_presence_of :user 

  accepts_nested_attributes_for :bucket
#  attr_accessible :bucket_id, :bucket_attributes

  def to_description_hash
    {:title => name, :id => id}
  end
end
