FactoryBot.define do
  factory :card_comment, class: 'CardComment' do
    sequence(:id, &:to_i)
    text { |i| "My Comment #{i}" }
    card
    auth
  end
end
