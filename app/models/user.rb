class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :omniauthable, :invitable?
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :encryptable, :encryptor => :sha1 

  # Setup accessible (or protected) attributes for your model
  # SMELL these need to be moved to a controller. How does Devise handle this?
  # attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  validates_presence_of :name
  validates_uniqueness_of :email, :case_sensitive => false
  
  has_many :items
  has_many :loans
  has_many :borrowers
  has_many :buckets
end
