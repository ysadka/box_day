class Event < ActiveRecord::Base
  
  validates :date, presence: true
  validates :name, presence: true

  has_many :prizes
end
