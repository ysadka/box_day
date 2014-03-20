require 'spec_helper'

describe Event, 'validations' do
  it { expect(subject).to validate_presence_of(:date) }
  it { expect(subject).to validate_presence_of(:name) }
end

describe Event, 'associations' do
  it { expect(subject).to have_many(:prizes) }
end
