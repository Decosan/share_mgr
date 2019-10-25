class CommentsController < ApplicationController
  before_action :set_comment, only:[:destroy]
  before_action :correct_user, only:[:destroy]
  
  def create
    @event = Event.find(params[:event_id])
    @comment = @event.comments.new(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to event_path(@event) }
      else
        format.html { redirect_to event_path(@event), notice: 'コメントが空です(^o^)／' }
      end
    end 
  end

  def destroy
    @comment.destroy
    flash[:danger] ='コメント削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def comment_params
    params.require(:comment).permit(:event_id, :content)
  end

  def correct_user
    unless @comment.user.id == current_user.id
      redirect_back(fallback_location: root_path)
    end
  end
end
