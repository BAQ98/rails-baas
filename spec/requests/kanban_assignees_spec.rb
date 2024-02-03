require 'rails_helper'

RSpec.describe "KanbanAssignees", type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end
  let(:auth) { create(:auth) }
  before { sign_in auth }
  # Create auths
  let(:auths) { create_list(:auth, 3) }

  # Create profiles associated to each auth
  # Create Kanban and Profiles
  let(:kanban) { create(:kanban) }
  let(:profiles) do
    auths.map do |auth|
      create(:profile, auth: auth)
    end
  end

  # Create Assignees
  let(:kanban_assignee) do
    build_list(:kanban_assignee, 3) do |assignee|
      assignee.kanban = kanban
      assignee.profile = profiles.sample
    end
  end

  describe 'GET kanban_assignee' do
    context 'valid request from client' do
      it 'should successful' do
        get api_kanban_assignees_path, params: {
          kanban_assignees: {
            kanban_id: 1
          }
        }, headers: headers
        expect(response).to have_http_status(200)
      end
    end
  end

end
