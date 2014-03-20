class Winner < ActiveRecord::Base

  validates :prize_id,  presence: true
  validates :tweet_id, presence: true
  
  belongs_to :prize
  belongs_to :tweet
end
