# frozen_string_literal: true

class KanbanAssigneesController < ApplicationController
  before_action :authenticate_auth!

  def create
    @kanban_assignee = KanbanAssignee.new(kanban_assignee_params)
  end

  private

  def kanban_assignee_params
    params.require(:kanban_assignee).permit(:kanban_id, profile_ids: []) do |p|
      p[:profile_ids] = p[:profile_ids].reject(&:empty?) if p[:profile_ids].present?
    end
  end
end
