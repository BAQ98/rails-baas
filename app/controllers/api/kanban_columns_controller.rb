module Api
  class KanbanColumsController < ApplicationController
    before_action :authenticate_auth!

    def index
      binding.pry
    end

    def create
      @kanban_column = KanbanColumn.create!(kanban_column_params)
    end

    private

    def set_kanban_collums

    end

    def kanban_column_params
      params.require(:kanban_column).permit(:kanban_id, :name)
    end

  end
end