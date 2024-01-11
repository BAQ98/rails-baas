# frozen_string_literal: true

FactoryBot.define do
  factory :kanban, class: 'Kanban' do
    id { 1 }
    name { "Project foo " }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
  end
end
