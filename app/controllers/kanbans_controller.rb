# frozen_string_literal: true
class KanbansController < ApplicationController
  before_action :authenticate_auth!
  before_action :set_kanban, only: %i[ show sort ]

  # GET /kanbans or /kanbans.json
  def index
    @kanbans = Kanban.all
    @kanban = Kanban.new
  end

  # GET /kanbans/1 or /kanbans/1.json
  def show
    @kanban_columns = KanbanColumn.where(kanban_id: @kanban.id)
    @kanban_column = KanbanColumn.new
    @kanbans = Rails.cache.fetch('all_kanbans') do
      Kanban.all
    end
    
  end

  # POST /kanbans or /kanbans.json
  def create
    @kanban = Kanban.new(kanban_params)
    respond_to do |format|
      if @kanban.save!
        format.html { redirect_to kanbans_path, notice: "#{@kanban.name} was successfully created." }
        format.json { render json: @kanban, status: :created }
      else
        flash[:error] = "#{@kanban.name} couldn't created. Something went wrong!"
        format.json { render json: @kanban.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kanbans/1 or /kanbans/1.json
  def destroy
    @kanban.destroy!
  end

  def sort
    sorted_cols = JSON.parse(kanban_params["kanbanIds"])["columns"]
    sorted_cols.each do |col|
      col["cardIds"].each do |card_id|
        Card.find(card_id).update!(
          kanban_column: KanbanColumn.find(col["id"]),
          position: col["cardIds"].find_index(card_id)
        )
      end
    end
  end

  private

  def set_kanban
    @kanban = Kanban.find(params[:id])
  end

  def kanban_params
    params.require(:kanban).permit(:name, :description, :kanbanIds)
  end
end
