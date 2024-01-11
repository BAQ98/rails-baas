FactoryBot.define do
  factory :kanban_column, class: 'KanbanColumn' do
    sequence(:id, &:to_i)
    name { "Column Name" }
    kanban
  end
end
