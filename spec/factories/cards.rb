FactoryBot.define do
  factory :card, class: 'Card' do
    sequence(:id, &:to_i)
    title { |i| "Card task #{i}" }
    content { "Card Content" }
    kanban_column
    trait :with_position do
      position { kanban_column.cards.length.to_i + 1 }
    end
  end
end
