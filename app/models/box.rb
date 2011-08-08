class Box < ActiveRecord::Base
	belongs_to :user
	belongs_to :app
	has_many :page_boxes
	has_many :pages, :through => :page_boxes
end
