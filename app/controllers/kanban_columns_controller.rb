class KanbanColumnsController < ApplicationController
  before_action :authenticate_auth!
  before_action :set_instances, only: %i[ destroy update show ]

  def index
  end

  def create
    @kanban_column = KanbanColumn.new(kanban_column_params)
    respond_to do |format|
      if @kanban_column.save!
        format.html { redirect_to kanban_path(@kanban_column.kanban_id),
                                  notice: "#{@kanban_column.name} was successfully created." }
      else
        flash[:error] = "#{@kanban_column.name} couldn't created. Something went wrong!"
      end
    end
  end

  def update
    @kanban_column.update!(kanban_column_params)
    respond_to do |format|
      if @kanban_column.save!
        format.html { redirect_to kanban_path(@kanban_column.kanban_id),
                                  notice: "Group was successfully rename to #{@kanban_column.name}" }
      else
        flash[:error] = "#{@kanban_column.name} couldn't rename. Something went wrong!"
      end
    end
  end

  def destroy
    respond_to do |format|
      if @kanban_column.destroy!
        format.html { redirect_to kanban_path(@kanban_column.kanban_id),
                                  notice: "#{@kanban_column.name} group was deleted!" }
      else
        flash[:error] = "#{@kanban_column.name} couldn't delete. Something went wrong!"
      end
    end
  end

  def show

  end

  private

  def set_instances
    @kanban_column = KanbanColumn.find(params[:id])
  end

  def kanban_column_params
    params.require(:kanban_column).permit(:name, :kanban_id)
  end

end
