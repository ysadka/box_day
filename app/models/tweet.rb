class Tweet < ActiveRecord::Base
  
  validates :body,     presence: true
  validates :replied,  inclusion: {in: [true, false]}
  validates :username, presence: true

  has_many :winners
end
