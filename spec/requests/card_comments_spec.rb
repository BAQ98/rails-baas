require 'rails_helper'

RSpec.describe "CardComment", type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end
  let(:auth) { create(:auth) }
  before { sign_in auth }
  let(:profile) { create(:profile, auth: auth) }
  let(:kanban) { create(:kanban, author: Profile.find(profile.id)) }
  let(:kanban_column) { create(:kanban_column, kanban: kanban) }
  let(:card) { create(:card, kanban_column: kanban_column) }

=begin
  # describe "POST /create" do
  #   context "with valid parameters" do
  #     it "creates a new CardComment" do
  #       expect {
  #         post card_comments_url, params: { card_comment: valid_attributes }
  #       }.to change(CardComment, :count).by(1)
  #     end
  #
  #     it "redirects to the created card_comment" do
  #       post card_comments_url, params: { card_comment: valid_attributes }
  #       expect(response).to redirect_to(card_comment_url(CardComment.last))
  #     end
  #   end
  # end
=end

end
