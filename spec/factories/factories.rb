FactoryGirl.define do
  sequence :username do |n|
    "username#{n}"
  end

  factory :user do
    username
    # password
    # balance 100_00
  end

  # factory :sell do
  #   association :seller, factory: :user
  #   player
  #   price 10_00
  #   shares 1
  #   role 'pending'
  # end

  # factory :player do
  #   first_name    'Yaron'
  #   last_name     'Sadka'
  #   draft_year    Time.now.year
  #   ipo           32_00
  #   current_price 320_00
  #   last_ask      35_00
  # end
end
