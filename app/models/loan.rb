# NOTE See http://blog.aviflombaum.com/blog/2012/07/dont-use-accepts-nested-attributes-for-with-belongs-to/
class Loan < ActiveRecord::Base
  belongs_to :user
  belongs_to :borrower
  belongs_to :item
  
  accepts_nested_attributes_for :borrower
  # attr_accessible :borrower_id, :borrower_attributes
  
  accepts_nested_attributes_for :item
  # attr_accessible :item_id, :item_attributes
  
  
  def borrower_attributes=(borrower_attributes)
    self.borrower = self.user.borrowers.find_or_create_by_email(borrower_attributes[:email])
  end
  
  def item_attributes=(item_attributes)
    self.item = self.user.items.find_or_create_by_name(item_attributes[:name])
  end
  
  # Law of Demeter. Talk to your friends, but not your friends' friends
  def item_name
    self.item ? self.item.name : '<no item>'  
  end
  
  def borrower_name
    return '<no borrower>' unless self.borrower
    return self.borrower.name unless self.borrower.name.blank?
    return self.borrower.email unless self.borrower.email.blank?
    '<no borrower>'    
  end  
end
