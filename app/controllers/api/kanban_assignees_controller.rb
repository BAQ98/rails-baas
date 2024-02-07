# frozen_string_literal: true

module Api
  class KanbanAssigneesController < ApplicationController
    before_action :authenticate_auth!
    before_action :validates_kanban_author, only: [:assign]

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
        else
          format.json { render json: @kanban_assignees.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def validates_kanban_author
      kanban = Kanban.find(kanban_assignee_params['kanban_id'])
      return if current_auth.id == kanban.author.id

      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.prepend('flash', partial: '/components/partial/flash')
        }
        format.json {
          render json: {
            error: :unauthorized,
            status: 401,
            message: 'Only creator can assign users for this project!'
          }
        }

      end
    end

    def kanban_assignee_params
      params.require(:kanban_assignees).permit(:assignees_list_in_kanban, :kanban_id)
    end
  end

end
