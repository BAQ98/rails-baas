# require 'rails_helper'
#
# RSpec.describe "KanbanAssignees", type: :request do
#   let(:headers) do
#     { 'ACCEPT' => 'application/json' }
#   end
#   let(:auth) { create(:auth) }
#   before { sign_in auth }
#   let(:profile) { create_list(:profile, 2) }
#   let(:kanban) { create(:kanban, author: Profile.find(profile.id)) }
#
#   describe "POST /create" do
#     let(:kanban_assignees) {
#       [
#         {
#           profile_id: 1, kanban_id: 1
#         },
#         {
#           profile_id: 2, kanban_id: 1
#         }
#       ]
#     }
#     context 'in client with json accepted' do
#       it 'successfully' do
#         post kanban_assignees_path, params: {
#           kanban_assignees: kanban_assignees
#         }, headers: headers
#         binding.pry
#         expect(response).to be_successful
#       end
#     end
#   end
# end
