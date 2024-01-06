# frozen_string_literal: true
module Api
  class KanbansController < ApplicationController
    before_action :authenticate_auth!
    before_action :set_kanban, only: %i[ show edit update destroy ]

    # GET /kanbans or /kanbans.json
    def index
      @kanbans = Kanban.all
      @kanban = Kanban.new
    end

    # GET /kanbans/1 or /kanbans/1.json
    def show
      @kanbans = Rails.cache.fetch('all_kanbans') do
        Kanban.all
      end
    end

    # GET /kanbans/new
    def new
      @kanban = Kanban.new
    end

    # GET /kanbans/1/edit
    def edit
    end

    # POST /kanbans or /kanbans.json
    def create
      @kanban = Kanban.new(kanban_params)
      respond_to do |format|
        if @kanban.save!
          flash[:success] = "#{@kanban.name} was successfully created"
          format.html { redirect_to kanbans_path, notice: "#{@kanban.name} was successfully created." }
          format.json { render json: @kanban, status: :created }
        else
          flash[:error] = "#{@kanban.name} couldn't created. Something went wrong!"
          format.json { render json: @kanban.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /kanbans/1 or /kanbans/1.json
    def update
      respond_to do |format|
        if @kanban.update(kanban_params)
          format.html { redirect_to kanban_url(@kanban), notice: "Kanban was successfully updated." }
          format.json { render :show, status: :ok, location: @kanban }
        else
          format.html { render :edit, status: :unprocessable_entity, notice: "Something went wrong!" }
          format.json { render json: @kanban.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /kanbans/1 or /kanbans/1.json
    def destroy
      @kanban.destroy!
      respond_to do |format|
        format.html { redirect_to kanbans_url, notice: "Kanban was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    def sort
      # Get the new col sort
      sorted_cols = JSON.parse(kanban_params["kanbanIds"])["columns"]
      sorted_cols.each do |col|
        # Look at each of its cards
        col["itemIds"].each do |card_id|
          # Find the card if in the DB and
          # update its column and position within the column
          Card.find(card_id).update(
            kanban_column: KanbanColumn.find(col["id"]),
            position: col["itemIds"].find_index(card_id)
          )
        end
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_kanban
      @kanban = Kanban.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def kanban_params
      params.require(:kanban).permit(:name, :description, :kanbanIds)
    end
  end
end
