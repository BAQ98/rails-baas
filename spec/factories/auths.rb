FactoryBot.define do
  factory :auth, class: "Auth" do
    sequence(:id) { |i| i.to_i }
    sequence(:email) { |i| "foo_#{i}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
