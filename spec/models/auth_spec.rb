require "rails_helper"

RSpec.describe Auth, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation).on(:create) }
  it { should validate_confirmation_of(:password).on(:create) }
end
