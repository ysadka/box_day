class Prize < ActiveRecord::Base

  validates :event_id, presence: true
  validates :name,     presence: true

  belongs_to :event
  has_many :winners
end
