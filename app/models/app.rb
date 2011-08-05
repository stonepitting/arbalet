class App < ActiveRecord::Base
  belongs_to :user
  has_many :pages
  has_many :tips
  
  validates_presence_of :name, :url
end
