FactoryBot.define do
  factory :card_comment do
    text { "MyString" }
    card { nil }
    auth { nil }
  end
end
