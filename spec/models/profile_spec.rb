require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:auth) { create(:auth) }
  let(:profile) { create(:profile) }

  it { should belong_to(:auth) }
  it { should validate_uniqueness_of(:username) }
  it { should have_many(:kanbans) }

  it 'should include auth' do
    expect(profile.auth.email).to be_truthy
  end

  describe 'validate avatar' do
    it { is_expected.to validate_content_type_of(:avatar).allowing('image/png', 'image/jpeg') }
    it { is_expected.to validate_size_of(:avatar).less_than(1.megabyte) }
  end
end
