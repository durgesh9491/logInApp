class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.creator_id = current_user.id
    if @comment.save
      flash[:success] = 'Comment was successfully created.'
    else
      flash[:notice] = "Error creating comment !"
    end
    redirect_to :back
  end

 def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
 end


  private
    def comment_params
      params.require(:comment).permit(:content, :micropost_id, :creator_id)
    end
end
