require 'spec_helper'

describe Prize, 'validations' do
  it { expect(subject).to validate_presence_of(:event_id) }  
  it { expect(subject).to validate_presence_of(:name) }  
end

describe Prize, 'associations' do
  it { expect(subject).to belong_to(:event) }
  it { expect(subject).to have_many(:winners) }
end
