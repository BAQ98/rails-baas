require 'rails_helper'

RSpec.describe 'CardComment', type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json', 'HTTP_REFERER' => card_path(card.id) }
  end
  let(:auth) { create(:auth) }
  before { sign_in auth }
  let(:profile) { create(:profile, auth: auth) }
  let(:kanban) { create(:kanban, author: Profile.find(profile.id)) }
  let(:kanban_column) { create(:kanban_column, kanban: kanban) }
  let(:card) { create(:card, kanban_column: kanban_column) }
  let(:card_comment) { create(:card_comment, card: card, auth: auth) }
  let(:kanban_assignee) { create(:kanban_assignee, kanban: kanban, profile: profile) }

  describe 'POST /create' do
    let(:valid_attributes) {
      {
        text: 'Comment',
        card_id: card.id,
        auth_id: auth.id
      }
    }

    it 'should successful' do
      post card_comments_path,
           params: { card_comment: valid_attributes },
           headers: { 'HTTP_REFERER' => card_path(kanban.id) }
      expect(response).to have_http_status(302)
    end
  end

  describe 'PATCH /update' do
    let(:new_valid_attributes) {
      {
        text: 'New Comment',
        auth_id: auth.id,
        card_id: card.id
      }
    }

    it 'should updated' do
      patch card_comment_path(card_comment.id), params: { card_comment: new_valid_attributes }
      expect(response).to have_http_status(302)
    end
  end

  describe 'DELETE /destroy' do

    it 'should updated' do
      delete card_comment_path(card_comment.id)
      expect(response).to have_http_status(302)
    end
  end

end
