class CardsController < ApplicationController
  before_action :authenticate_auth!

  def index
  end

  def create
    @card = Card.new(card_params)
    respond_to do |format|
      if @card.save!
        format.html { redirect_to :back, flash[:notice] = "#{@card.title} was created!" }
        format.json { render json: @card, status: :created }
      else
        flash[:error] = "#{@card.name} couldn't created. Something went wrong!"
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def card_params
    params.require(:card).permit(:title, :content, :position, :kanban_column_id)
  end
end
