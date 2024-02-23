module Authorization
  extend ActiveSupport::Concern

  def authorized_assignees?(params)
    if params.key?(:id) || params.key?(:kanban_column_id)
      kanban_id = KanbanColumn.find(params[:id] || params[:kanban_column_id]).kanban_id
    elsif params.key?(:kanban_id)
      kanban_id = Kanban.find(params[:kanban_id]).id
    elsif params.key?(:card_id)
      kanban_id = Card.find(params[:card_id]).kanban_column.kanban_id
    end

    is_authorized = KanbanAssignee.where(kanban_id: kanban_id)
                                  .exists?(profile_id: current_auth.id)

    return if is_authorized

    respond_to do |format|
      flash[:error] = 'Only Assignee can modify'
      format.html { redirect_to request.referrer }
      format.json { render json: :unauthorized, status: :unauthorized }
    end
  end

  def authorized_kanban_author(params)
  end

end