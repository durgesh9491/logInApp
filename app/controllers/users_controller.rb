class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :following, :followers, :show]
  before_action :correct_user,   only: [:edit, :update]


  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @micropost = current_user.microposts.build
    @post_comments_hash = {}
    @microposts.each do |micropost|
      @post_comments_hash[micropost.id] = micropost.comments;
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "SignIn successful !"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
     @users = User.paginate(page: params[:page])
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end


end
