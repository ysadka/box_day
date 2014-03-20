require 'spec_helper'

describe User, 'validations' do
  it { expect(subject).to validate_presence_of(:oauth_secret) }
  it { expect(subject).to validate_presence_of(:oauth_token) }
  it { expect(subject).to validate_presence_of(:provider) }
  it { expect(subject).to validate_presence_of(:uid) }
  it { expect(subject).to validate_presence_of(:username) }
end

describe User, 'associations' do
end
