require 'rails_helper'

RSpec.describe KanbanColumn, type: :model do
  it { should belong_to :kanban }
end
