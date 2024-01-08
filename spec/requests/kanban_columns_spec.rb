require 'rails_helper'

RSpec.describe "Api::KanbanColumns", type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end
  let(:auth) { create(:auth) }
  before { sign_in auth }
  let(:kanban) { create(:kanban) }

  describe 'POST /create' do
    let(:valid_attributes) {
      {
        name: "New Kanban column",
        kanban_id: kanban.id
      }
    }
    context 'create kanban columns in kanban show view' do
      context 'with valid parameters' do
        it 'creates a new Kanban' do
          post kanban_columns_path, params: { kanban_column: valid_attributes },
               headers: headers
          expect(response).to have_http_status(:created)
          kanban_column = KanbanColumn.last
          expect(kanban_column.name).to eq("New Kanban column")
          expect(kanban_column.kanban_id).to eq(kanban.id)
        end
        it "renders errors for invalid params" do
          post kanban_columns_path, params: {}, headers: headers
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end
end
