require 'rails_helper'

RSpec.describe "Cards", type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json', 'HTTP_REFERER' => card_path(card.id) }
  end
  let(:auth) { create(:auth) }
  before { sign_in auth }
  let(:profile) { create(:profile, auth: auth) }
  let(:kanban) { create(:kanban, author: Profile.find(profile.id)) }
  let(:kanban_column) { create(:kanban_column, kanban: kanban) }
  let(:card) { create(:card, kanban_column: kanban_column) }

  describe "POST /create card" do
    context 'create with valid attributes' do
      let(:unvalid_attributes) {
        {
          title: Faker::App.name,
          content: Faker::Lorem.paragraph,
          position: kanban_column.cards.length + 1,
          kanban_column_id: kanban_column.id
        }
      }

      it 'is not assignee' do
        post cards_path, params: { card: unvalid_attributes },
             headers: headers
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /destroy card' do
    context 'Delete with existing card' do
      it 'is successful and redirect' do
        delete card_path(card.id), params: {
          card: {
            kanban_column_id: kanban_column.id
          }
        }, headers: headers
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PATCH /update card' do
    context 'Update with valid parameters' do
      let(:valid_attributes) {
        {
          title: Faker::App.name,
          content: Faker::Lorem.paragraph,
          kanban_column_id: kanban_column.id
        }
      }
      it 'is successful and redirect' do
        patch card_path(card.id), params: { card: valid_attributes },
              headers: headers
        expect(response).to have_http_status(401)
      end
    end
  end
end
