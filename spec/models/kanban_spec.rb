require 'rails_helper'

RSpec.describe Kanban, type: :model do
  it { should validate_uniqueness_of(:name) }
end
