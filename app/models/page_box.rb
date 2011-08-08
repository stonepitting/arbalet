class PageBox < ActiveRecord::Base
  belongs_to :page
  belongs_to :box
  belongs_to :app
  belongs_to :user
end
