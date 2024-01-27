# frozen_string_literal: true

FactoryBot.define do
  factory :kanban, class: 'Kanban' do
    sequence(:id, &:to_i)
    sequence(:name) { |i| "#{Faker::Name.name} #{i}" }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    association :profile
  end
end
