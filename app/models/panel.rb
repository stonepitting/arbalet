class Panel < ActiveRecord::Base
	belongs_to :user
	belongs_to :app
	has_many :page
end
