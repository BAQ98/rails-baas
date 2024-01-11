class CardsController < ApplicationController
  before_action :authenticate_auth!
  before_action :set_card, only: %i[ show update destroy ]

  def index
  end

  def show
  end

  def update
  end

  def destroy
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

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:title, :content, :position, :kanban_column_id)
  end

end
