class SubcommentsController < ApplicationController
  def create
    @subcomment = Subcomment.new(subcomment_params)
    @subcomment.creator_id = current_user.id
    if @subcomment.save
      flash[:success] = 'successfully Replied.'
    else
      flash[:notice] = "Error creating reply !"
    end
    redirect_to :back
  end

 def destroy
    @subcomment = Subcomment.find(params[:id])
    @subcomment.destroy
    redirect_to :back
 end


def upvote
  @Subcomment = Subcomment.find(params[:id])
  @Subcomment.upvote_by current_user
  redirect_to :back
end

def downvote
  @Subcomment = Subcomment.find(params[:id])
  @Subcomment.downvote_by current_user
  redirect_to :back
end

  private
    def subcomment_params
      params.require(:subcomment).permit(:content, :comment_id, :creator_id)
    end
end

