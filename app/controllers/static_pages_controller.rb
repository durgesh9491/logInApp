class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:home]

  def home
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page])
    @post_comments_hash = {}
    @feed_items.each do |micropost|
      @post_comments_hash[micropost.id] = micropost.comments;
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
