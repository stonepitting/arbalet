class Tip < ActiveRecord::Base
  belongs_to :app
  belongs_to :user
  
  validates_presence_of :content
end
