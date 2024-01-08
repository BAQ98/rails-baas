class KanbanColumnsController < ApplicationController
  before_action :authenticate_auth!

  def index
  end

  def create
    @kanban_column = KanbanColumn.new(kanban_column_params)
    respond_to do |format|
      if @kanban_column.save!
        format.html { redirect_to kanban_path(@kanban_column.kanban_id),
                                  notice: "#{@kanban_column.name} was successfully created." }
        format.json { render json: @kanban_column, status: :created }
      else
        flash[:error] = "#{@kanban_column.name} couldn't created. Something went wrong!"
        format.json { render json: @kanban_column.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def kanban_column_params
    params.require(:kanban_column).permit(:name, :kanban_id)
  end

end
