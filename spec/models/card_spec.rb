require 'rails_helper'

RSpec.describe Card, type: :model do
  it { should validate_presence_of(:title) }
  it { should belong_to :kanban_column }
end
