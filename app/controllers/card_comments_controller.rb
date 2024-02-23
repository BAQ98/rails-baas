class CardCommentsController < ApplicationController
  before_action :authenticate_auth!
  before_action :set_card_comment, only: %i[ update destroy ]
  before_action only: %i[create update destroy] do
    authorized_assignees?(card_comment_params[''])
  end
  # POST /card_comments
  def create
    @card_comment = CardComment.new(card_comment_params)
    respond_to do |format|
      if @card_comment.save!
        format.html { redirect_to card_path(@card_comment.card_id) }
        format.json { render json: @card_comment, status: :created }
      else
        format.html { redirect_to card_path(@card_comment.card_id), error: 'Something was wrong!' }
        format.json { render json: @card_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_comments/1
  def update
    respond_to do |format|
      if @card_comment.update(card_comment_params)
        format.html { redirect_to card_path(@card_comment.card_id) }
        format.json { render json: @card_comment, status: :ok }
      else
        format.html { redirect_to card_path(@card_comment.card_id), error: 'Something wrong' }
        format.json { render json: @card_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_comments/1
  def destroy
    @card_comment.destroy!
    respond_to do |format|
      format.html { redirect_to card_path(@card_comment.card_id) }
      format.json { head :no_content }
    end
  end

  private

  def set_card_comment
    @card_comment = CardComment.find(params[:id])
  end

  def card_comment_params
    params.require(:card_comment).permit(:text, :card_id, :auth_id, :id)
  end
end
