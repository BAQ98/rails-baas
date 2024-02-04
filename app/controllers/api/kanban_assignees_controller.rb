# frozen_string_literal: true

module Api
  class KanbanAssigneesController < ApplicationController
    before_action :authenticate_auth!

    def get_assignees
      @kanban_assignees = KanbanAssignee.where(kanban_id: kanban_assignee_params['kanban_id'])
      respond_to do |format|
        if @kanban_assignees
          format.json { render json: @kanban_assignees, status: :ok }
        else
          format.json { render json: @kanban_assignees.errors, status: :not_found }
        end
      end
    end

    def assign
      KanbanAssignee.delete_by(kanban_id: kanban_assignee_params[:kanban_id])
      kanban_assignees = JSON.parse(kanban_assignee_params['assignees_list_in_kanban'])
      respond_to do |format|
        if KanbanAssignee.create!(kanban_assignees)
          format.json { render json: @kanban_assignees, status: :created }
          format.turbo_stream { flash.now[:notice] = 'Users assigned successfully.' }
        else
          format.json { render json: @kanban_assignees.errors, status: :unprocessable_entity }
        end
      end
    end

    def reassign
      kanban_assignees = JSON.parse(kanban_assignee_params['assignees_list_in_kanban'])
      respond_to do |format|
        if KanbanAssignee.create!(kanban_assignees)
          format.html { redirect_to kanban_path(kanban_assignee_params[:kanban_id]),
                                    notice: 'Users assigned successfully.', status: :found }
          format.json { render json: @kanban_assignees, status: :created }
          format.turbo_stream { flash.now[:notice] = 'Users assigned successfully.' }
        else
          format.json { render json: @kanban_assignees.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def kanban_assignee
      JSON.parse(kanban_assignee_params['assignees_list_in_kanban'])
    end

    def kanban_assignee_params
      params.require(:kanban_assignees).permit(:assignees_list_in_kanban, :kanban_id)
    end
  end

end
