FactoryBot.define do
  factory :card do
    title { "MyString" }
    content { "MyString" }
    position { 1 }
    kanban_column { nil }
  end
end
