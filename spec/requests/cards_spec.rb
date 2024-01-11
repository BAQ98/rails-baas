require 'rails_helper'

RSpec.describe "Cards", type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end
  let(:auth) { create(:auth) }
  before { sign_in auth }
  let(:kanban) { create(:kanban) }

  describe "POST /create card" do
    context 'create with valid attributes' do
      let(:kanban_column) { create(:kanban_column, kanban: kanban) }
      let(:card) { create(:card, kanban_column: kanban_column) }
      let(:valid_attributes) {
        {
          title: Faker::App.name,
          content: Faker::Lorem.paragraph,
          position: kanban_column.cards.length + 1,
          kanban_column_id: kanban_column.id
        }
      }
      it 'is successful' do
        post cards_path, params: { card: valid_attributes }, headers: headers
        expect(response).to be_successful
      end
    end
  end
end
