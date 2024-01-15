FactoryBot.define do
  factory :kanban_column, class: 'KanbanColumn' do
    sequence(:id, &:to_i)
    name { |i| "Column Name #{i}" }
    kanban
  end
end
