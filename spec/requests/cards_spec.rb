require 'rails_helper'

RSpec.describe "Cards", type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end
  let(:auth) { create(:auth) }
  before { sign_in auth }
  let(:profile) { create(:profile, auth: auth) }
  let(:kanban) { create(:kanban, author: Profile.find(profile.id)) }
  let(:kanban_column) { create(:kanban_column, kanban: kanban) }
  let(:card) { create(:card, kanban_column: kanban_column) }

  describe "POST /create card" do
    context 'create with valid attributes' do
      let(:valid_attributes) {
        {
          title: Faker::App.name,
          content: Faker::Lorem.paragraph,
          position: kanban_column.cards.length + 1,
          kanban_column_id: kanban_column.id
        }
      }

      it 'is successful' do
        post cards_path, params: { card: valid_attributes }
        binding.pry
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy card' do
    context 'Delete with existing card' do
      it 'is successful and redirect' do
        delete card_path(card.id)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'PATCH /update card' do
    context 'Update with valid parameters' do
      let(:valid_attributes) {
        {
          title: Faker::App.name,
          content: Faker::Lorem.paragraph,
        }
      }
      it 'is successful and redirect' do
        patch card_path(card.id), params: { card: valid_attributes }
        expect(response).to have_http_status(302)
      end
    end
  end
end
