class CardsController < ApplicationController
  before_action :authenticate_auth!
  before_action :set_instances, only: %i[ show update destroy ]
  before_action :authorized_assignees?, only: %i[ create update destroy ]

  def show
  end

  def create
    @card = Card.new(card_params)
    respond_to do |format|
      if @card.save!
        format.html { redirect_to request.referrer, notice: "#{@card.title} was created!" }
        format.json { render json: @card, status: :created }
      else
        flash[:error] = "#{@card.name} couldn't created. Something went wrong!"
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @card.update!(card_params)
        format.html { redirect_to card_path(@card), notice: "#{@card.title} card was updated!" }
      else
        flash[:error] = "#{@card.title} couldn't update. Something went wrong!"
        format.html { redirect_to card_path(@card) }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Card.destroy(@card.id)
    respond_to do |format|
      if response.successful?
        format.html {
          redirect_to kanban_path(@kanban_column.kanban_id),
                      notice: "#{@card.title} card was delete!" }
      else
        flash[:error] = "#{@card.title} couldn't delete. Something went wrong!"
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def authorized_assignees?
    kanban_id = KanbanColumn.find(card_params['kanban_column_id']).kanban_id
    is_authorized = KanbanAssignee.where(kanban_id: kanban_id)
                                  .exists?(profile_id: current_auth.id)
    return if is_authorized

    respond_to do |format|
      flash[:error] = 'Only Assignee can modify'
      format.html { redirect_to request.referrer }
      format.json { render json: @card.errors, status: :unauthorized }
    end
  end

  def set_instances
    @card = Card.find(params[:id])
    @kanban_column = KanbanColumn.find(@card.kanban_column_id)
  end

  def card_params
    params.require(:card).permit(:title, :content, :position, :kanban_column_id)
  end

end
