class MicropostsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy, :show]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      respond_to do |format|
        format.html do
          redirect_to :back
        end
        format.js do
        end
      end
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

  def upvote
    @Micropost = Micropost.find(params[:id])
    if current_user.voted_up_on? @Micropost
      @Micropost.unliked_by current_user
    else
      @Micropost.upvote_by current_user
    end
    redirect_to :back
  end

  def downvote
    @Micropost = Micropost.find(params[:id])
    if current_user.voted_down_on? @Micropost
      @Micropost.undisliked_by current_user
    else
      @Micropost.downvote_by current_user
    end
    redirect_to :back
  end


  private
    def micropost_params
      params.require(:micropost).permit(:content, :user_id)
    end

end
