require 'rails_helper'

RSpec.describe "card_comments/edit", type: :view do
  let(:card_comment) {
    CardComment.create!(
      text: "MyString",
      card: nil,
      auth: nil
    )
  }

  before(:each) do
    assign(:card_comment, card_comment)
  end

  it "renders the edit card_comment form" do
    render

    assert_select "form[action=?][method=?]", card_comment_path(card_comment), "post" do

      assert_select "input[name=?]", "card_comment[text]"

      assert_select "input[name=?]", "card_comment[card_id]"

      assert_select "input[name=?]", "card_comment[auth_id]"
    end
  end
end
