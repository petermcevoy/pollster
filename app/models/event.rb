class Event < ActiveRecord::Base
  belongs_to :user
	has_many :polls, :dependent => :destroy
	
	serialize :options, Hash
	
  validates_format_of :name, :with => /^[A-Za-z\d_]+$/, :message => "cannot contain spaces or funny characters."
  validates_uniqueness_of :name
end
