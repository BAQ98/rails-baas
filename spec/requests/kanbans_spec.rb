require 'rails_helper'

RSpec.describe 'Api::KanbansController', type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end
  let(:auth) { create(:auth) }
  let(:kanban) { create(:kanban) }
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }

  before do
    allow(Rails).to receive(:cache).and_return(memory_store)
    Rails.cache.clear
  end

  before { sign_in auth }

  describe 'GET /index' do
    context 'all kanbans exist' do
      it 'is successful' do
        get kanbans_path, headers: headers
        expect(response).to be_successful
      end
    end
  end

  describe 'POST /create' do
    let(:valid_attributes) {
      {
        name: "My Kanban",
        description: "A kanban board"
      }
    }
    context 'with valid parameters' do
      it 'creates a new Kanban' do
        post kanbans_path, params: { kanban: valid_attributes },
             headers: headers
        expect(response).to have_http_status(:created)
        kanban = Kanban.last
        expect(kanban.name).to eq("My Kanban")
        expect(kanban.description).to eq("A kanban board")
      end
      it "renders errors for invalid params" do
        post kanbans_path, params: {}, headers: headers
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

  # describe 'GET /edit' do
  #   it 'renders a successful response' do
  #     kanban = Kanban.create! valid_attributes
  #     get edit_kanban_url(kanban)
  #     expect(response).to be_successful
  #   end
  # end
  #
  #   context 'with invalid parameters' do
  #     it 'does not create a new Kanban' do
  #       expect {
  #         post kanbans_url, params: { kanban: invalid_attributes }
  #       }.to change(Kanban, :count).by(0)
  #     end
  #
  #     it 'renders a response with 422 status (i.e. to display the 'new' template)' do
  #       post kanbans_url, params: { kanban: invalid_attributes }
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #
  #   end
  # end
  #
  # describe 'PATCH /update' do
  #   context 'with valid parameters' do
  #     let(:new_attributes) {
  #       skip('Add a hash of attributes valid for your model')
  #     }
  #
  #     it 'updates the requested kanban' do
  #       kanban = Kanban.create! valid_attributes
  #       patch kanban_url(kanban), params: { kanban: new_attributes }
  #       kanban.reload
  #       skip('Add assertions for updated state')
  #     end
  #
  #     it 'redirects to the kanban' do
  #       kanban = Kanban.create! valid_attributes
  #       patch kanban_url(kanban), params: { kanban: new_attributes }
  #       kanban.reload
  #       expect(response).to redirect_to(kanban_url(kanban))
  #     end
  #   end
  #
  #   context 'with invalid parameters' do
  #
  #     it 'renders a response with 422 status (i.e. to display the 'edit' template)' do
  #       kanban = Kanban.create! valid_attributes
  #       patch kanban_url(kanban), params: { kanban: invalid_attributes }
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #
  #   end
  # end
  #
  # describe 'DELETE /destroy' do
  #   it 'destroys the requested kanban' do
  #     kanban = Kanban.create! valid_attributes
  #     expect {
  #       delete kanban_url(kanban)
  #     }.to change(Kanban, :count).by(-1)
  #   end
  #
  #   it 'redirects to the kanbans list' do
  #     kanban = Kanban.create! valid_attributes
  #     delete kanban_url(kanban)
  #     expect(response).to redirect_to(kanbans_url)
  #   end
  # end
end
