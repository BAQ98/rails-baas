# frozen_string_literal: true

FactoryBot.define do
  factory :auth, class: 'Auth' do
    sequence(:id, &:to_i)
    sequence(:email) { |i| "foo_#{i}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
