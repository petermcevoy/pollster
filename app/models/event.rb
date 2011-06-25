class Event < ActiveRecord::Base
  belongs_to :user
  
  validates_format_of :name, :with => /^[A-Za-z\d_]+$/
  validates_uniqueness_of :name
end
