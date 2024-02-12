require 'rails_helper'

RSpec.describe "card_comments/show", type: :view do
  before(:each) do
    assign(:card_comment, CardComment.create!(
      text: "Text",
      card: nil,
      auth: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Text/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
