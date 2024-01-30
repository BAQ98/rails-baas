# frozen_string_literal: true
class KanbansController < ApplicationController
  before_action :authenticate_auth!
  before_action :set_kanban, only: %i[ show sort destroy update add_assignees ]
  # GET /kanbans or /kanbans.json
  def index
    @kanbans = Kanban.all
    @kanban = Kanban.new
  end

  # GET /kanbans/1 or /kanbans/1.json
  def show
    @accounts = Rails.cache.fetch('all_accounts') { Profile.with_auth }
    # @account_options = @accounts.map do |account|
    #   { value: account.id, name: account.email }
    # end
    @kanbans = Rails.cache.fetch('all_kanbans') { Kanban.all }
    @kanban_columns = KanbanColumn.where(kanban_id: @kanban.id)
    @kanban_column = KanbanColumn.new
  end

  # POST /kanbans or /kanbans.json
  def create
    profile = Profile.with_auth.find_by(auths: { email: current_auth.email })
    @kanban = Kanban.new(kanban_params.merge(author: profile))
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
    respond_to do |format|
      if @kanban.destroy!
        format.html { redirect_to kanbans_path, notice: "#{@kanban.name} was delete!." }
        format.json { render json: @kanban, status: :no_content }
      else
        flash[:error] = "#{@kanban.name} couldn't delete. Something went wrong!"
        format.json { render json: @kanban.errors, status: :unprocessable_entity }
      end
    end
  end

  def sort
    sorted_cols = JSON.parse(kanban_params['kanbanIds'])['columns']
    sorted_cols.each do |col|
      col['cardIds'].each do |card_id|
        @card = Card.find(card_id)
        @card.update!(
          kanban_column: KanbanColumn.find(col['id']),
          position: col['cardIds'].find_index(card_id)
        )
      end
    end
  end

  def update
    respond_to do |format|
      if @kanban.update(kanban_params)
        format.html { redirect_to kanbans_path, notice: "#{@kanban.name} was updated!" }
        format.json { render json: @kanban, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @kanban.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_assignees(profiles)
    if @kanban.author_id == current_auth.id
      profiles.each do |profile|
        @kanban.assingees.create(profile:)
      end
    else

    end
  end

  private

  def set_kanban
    @kanban = Kanban.find(params[:id])
  end

  def kanban_params
    params.require(:kanban).permit(:name, :author, :description, :kanbanIds)
  end
end
