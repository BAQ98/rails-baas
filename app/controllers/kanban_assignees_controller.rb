# frozen_string_literal: true

class KanbanAssigneesController < ApplicationController
  before_action :authenticate_auth!

  def assign
    kanban_assignees = JSON.parse(kanban_assignee_params['assignees_list_in_kanban'])
    respond_to do |format|
      if KanbanAssignee.create!(kanban_assignees)
        format.html { redirect_to kanban_path(kanban_assignee_params[:kanban_id]), notice: "Users assigned successfully.",
                                  status: :found }
        format.json { render json: @kanban, status: :created }
      else
        format.json { render json: @kanban.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def kanban_assignee_params
    params.require(:kanban_assignees).permit(:assignees_list_in_kanban, :kanban_id)
  end
end
