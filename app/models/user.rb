class User < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  
  has_secure_password
  validates_presence_of :email
	validates_uniqueness_of :email
  validates_presence_of :password, :on => :create
  
  
end
