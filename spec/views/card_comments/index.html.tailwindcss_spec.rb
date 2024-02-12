require 'rails_helper'

RSpec.describe "card_comments/index", type: :view do
  before(:each) do
    assign(:card_comments, [
      CardComment.create!(
        text: "Text",
        card: nil,
        auth: nil
      ),
      CardComment.create!(
        text: "Text",
        card: nil,
        auth: nil
      )
    ])
  end

  it "renders a list of card_comments" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Text".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
