require 'spec_helper'

describe Tweet, 'validations' do
  it { expect(subject).to validate_presence_of(:body) }
  it { expect(subject).to validate_presence_of(:replied) }
  it { expect(subject).to validate_presence_of(:username) }
end

describe Tweet, 'associations' do
  it { expect(subject).to have_many(:winners) }
end
