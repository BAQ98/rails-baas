FactoryBot.define do
  factory :kanban_column do
    name { "Column Name" }
    kanban { nil }
  end
end
