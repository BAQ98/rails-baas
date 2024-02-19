require 'rails_helper'

RSpec.describe Kanban, type: :model do
  it { should validate_uniqueness_of(:name) }
  it { should belong_to(:author) }
  it { should have_many(:kanban_columns).dependent(:destroy) }

  it "assigns the author as a kanban assignee on create" do
    auth = create(:auth)
    kanban = create(:kanban, author: auth.profile)
    assignee = KanbanAssignee.find_by(
      kanban: kanban,
      profile: kanban.author
    )

    expect(assignee).to be_present
  end
end
