FactoryBot.define do
  factory :kanban_assignee do
    association :kanban
    association :profile

    trait :with_kanban do
      association :kanban
    end

    trait :with_profile do
      association :profile
    end
  end
end