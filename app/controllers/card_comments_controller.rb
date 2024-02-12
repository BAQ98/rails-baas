class CardCommentsController < ApplicationController
  before_action :set_card_comment, only: %i[ show edit update destroy ]

  # GET /card_comments or /card_comments.json
  def index
    @card_comments = CardComment.all
  end

  # GET /card_comments/1 or /card_comments/1.json
  def show
  end

  # GET /card_comments/new
  def new
    @card_comment = CardComment.new
  end

  # GET /card_comments/1/edit
  def edit
  end

  # POST /card_comments or /card_comments.json
  def create
    @card_comment = CardComment.new(card_comment_params)

    respond_to do |format|
      if @card_comment.save
        format.html { redirect_to card_comment_url(@card_comment), notice: "Card comment was successfully created." }
        format.json { render :show, status: :created, location: @card_comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_comments/1 or /card_comments/1.json
  def update
    respond_to do |format|
      if @card_comment.update(card_comment_params)
        format.html { redirect_to card_comment_url(@card_comment), notice: "Card comment was successfully updated." }
        format.json { render :show, status: :ok, location: @card_comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_comments/1 or /card_comments/1.json
  def destroy
    @card_comment.destroy!

    respond_to do |format|
      format.html { redirect_to card_comments_url, notice: "Card comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card_comment
      @card_comment = CardComment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_comment_params
      params.require(:card_comment).permit(:text, :card_id, :auth_id)
    end
end
