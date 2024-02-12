require 'rails_helper'

RSpec.describe "card_comments/new", type: :view do
  before(:each) do
    assign(:card_comment, CardComment.new(
      text: "MyString",
      card: nil,
      auth: nil
    ))
  end

  it "renders new card_comment form" do
    render

    assert_select "form[action=?][method=?]", card_comments_path, "post" do

      assert_select "input[name=?]", "card_comment[text]"

      assert_select "input[name=?]", "card_comment[card_id]"

      assert_select "input[name=?]", "card_comment[auth_id]"
    end
  end
end
