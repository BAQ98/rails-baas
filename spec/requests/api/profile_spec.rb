require 'rails_helper'

RSpec.describe 'Api::ProfileController', type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end
  let(:auth) { create(:auth) }
  let(:profile) { create(:profile, auth: auth) }

  before { sign_in auth }

  describe 'GET #show' do
    context 'profile is current auth and exist' do
      it 'is successful' do
        get profile_path
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid parameters' do
      let(:new_profile) {
        {
          auth_id: profile.auth.id,
          name: Faker::Name.name,
          username: Faker::Internet.username,
          position: Faker::Job.title,
          image_url: Faker::LoremFlickr.image,
          skills: [Faker::Job.key_skill, Faker::Job.key_skill, Faker::Job.key_skill]
        }
      }
      it 'is updated successfully!' do
        patch profile_path(profile.id), params: { profile: new_profile }, headers: headers
        expect(response).to redirect_to(account_path(auth.id))
      end
    end
  end
end
