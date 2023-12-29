# frozen_string_literal: true

FactoryBot.define do
  factory :profile, class: 'Profile' do
    sequence(:id, &:to_i)
    sequence(:username) { |i| "Username##{i}" }
    name { Faker::Name.name }
    position { Faker::Job.title }
    skills { [Faker::Job.key_skill, Faker::Job.key_skill, Faker::Job.key_skill] }
    
    association :auth
  end
end
