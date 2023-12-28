require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:auth) { create(:auth) }
  let(:profile) { create(:profile) }

  it { should belong_to(:auth) }
  it { should validate_uniqueness_of(:username) }

  it 'should include auth' do
    expect(profile.auth.email).to be_truthy
  end
end
