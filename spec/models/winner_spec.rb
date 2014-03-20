require 'spec_helper'

describe Winner, 'validations' do
  it { expect(subject).to validate_presence_of(:prize_id) }
  it { expect(subject).to validate_presence_of(:tweet_id) }
end

describe Winner, 'associations' do
  it{ expect(subject).to belong_to(:prize) }
  it{ expect(subject).to belong_to(:tweet) }
end
