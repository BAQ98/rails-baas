class KanbanColumnsController < ApplicationController
  before_action :authenticate_auth!
  before_action :set_instances, only: %i[ destroy ]

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

  def destroy
    respond_to do |format|
      if @kanban_column.destroy!
        format.html { redirect_to request.referrer,
                                  notice: "#{@kanban_column.name} group was deleted!" }
        format.json { render json: @kanban_column, status: :no_content }
      else
        flash[:error] = "#{@kanban_column.name} couldn't delete. Something went wrong!"
        format.json { render json: @kanban_column.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_instances
    @kanban_column = KanbanColumn.find(params[:id])
  end

  def kanban_column_params
    params.require(:kanban_column).permit(:name, :kanban_id)
  end

end
