class Page < ActiveRecord::Base
  belongs_to :app
  belongs_to :user
  
  validates_presence_of :name, :url
end
