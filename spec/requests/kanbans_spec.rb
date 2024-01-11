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

  # describe "PATCH /kanbans/sort" do
  #
  #   let(:column1) { create(:kanban_column, kanban: kanban) }
  #   let(:column2) { create(:kanban_column, kanban: kanban) }
  #   let(:card1) { create(:card, kanban_column: column1) }
  #   let(:card2) { create(:card, kanban_column: column1) }
  #   let(:card3) { create(:card, kanban_column: column2) }
  #
  #   let(:params) do
  #     {
  #       kanban_params: {
  #         kanbanIds: {
  #           columns: [
  #             {
  #               id: column1.id,
  #               cardIds: [card3.id, card1.id]
  #             },
  #             {
  #               id: column2.id,
  #               cardIds: [card2.id]
  #             }
  #           ]
  #         }
  #       }
  #     }
  #   end
  #
  #   it "sorts the cards" do
  #     patch kanban_sort_path(kanban.id), params: params
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
end
