require 'rails_helper'

RSpec.describe 'Api::KanbansController', type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end
  let(:auth) { create(:auth) }
  before { sign_in auth }
  let(:profile) { create(:profile, auth: auth) }
  let(:kanban) { create(:kanban, author: Profile.find(profile.id)) }
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }

  describe 'GET /index' do
    context 'all kanbans exist' do
      it 'is successful' do
        get kanbans_path
        expect(response).to be_successful
      end
    end
  end

  describe 'POST /create' do
    let(:valid_attributes) {
      {
        name: 'My Kanban',
        description: 'A kanban board',
        profile_id: profile.id
      }
    }
    context 'with valid parameters' do
      it 'creates a new Kanban' do
        post(kanbans_path, params: { kanban: valid_attributes },
             headers:)
        expect(response).to have_http_status(:created)
        kanban = Kanban.last
        expect(kanban.name).to eq('My Kanban')
        expect(kanban.description).to eq('A kanban board')
      end
      it 'renders errors for invalid params' do
        post(kanbans_path, params: {}, headers:)
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'GET /show' do
    context 'Render profiles and return truthy json' do
      it 'renders a successful response and caches all kanbans' do
        get kanbans_path(kanban.id)
        expect(Rails.cache.exist?('all_kanbans')).to be(false)
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested kanban' do
      delete kanban_path(kanban)
      expect(response).to redirect_to(kanbans_path)
    end
  end

  describe 'PATCH #update' do
    it 'updates the requested kanban' do
      patch kanban_path(kanban),
            params: { kanban: { name: 'New Name', description: 'New DESC' } }
      kanban.reload
      expect(kanban.name).to eq 'New Name'
      expect(response).to redirect_to(kanbans_path)
    end
  end
end
