class App < ActiveRecord::Base
  belongs_to :user
  has_many :pages
  
  validates_presence_of :name, :url
end
