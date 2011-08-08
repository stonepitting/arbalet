class Page < ActiveRecord::Base
  belongs_to :app
  belongs_to :user
  belongs_to :panel
  has_many :page_boxes
  has_many :boxes, :through => :page_boxes
  
  validates_presence_of :name, :url
end
