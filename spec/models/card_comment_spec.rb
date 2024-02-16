require 'rails_helper'

RSpec.describe CardComment, type: :model do
  it { should belong_to :auth }
  it { should belong_to :card }
end
