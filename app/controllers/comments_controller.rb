class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.creator_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html do
          redirect_to :back
        end
        format.js do
        end
      end
    else
      flash[:notice] = "Error creating comment!"
    end
  end

 def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
 end

  def upvote
    @Comment = Comment.find(params[:id])
    if current_user.voted_up_on? @Comment
      @Comment.unliked_by current_user
    else
     @Comment.upvote_by current_user
    end
    redirect_to :back
  end

  def downvote
    @Comment = Comment.find(params[:id])
    if current_user.voted_down_on? @Comment
      @Comment.undisliked_by current_user
    else
      @Comment.downvote_by current_user
    end
    redirect_to :back
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :micropost_id)
    end
end
