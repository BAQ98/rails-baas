# frozen_string_literal: true

FactoryBot.define do
  factory :kanban, class: 'Kanban' do
    sequence(:id, &:to_i)
    sequence(:name) { |i| "Project foo #{i}" }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
  end
end
