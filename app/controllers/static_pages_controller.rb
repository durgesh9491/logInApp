class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:home]

  def home
    @feed_items = current_user.feed.paginate(page: params[:page])
    @post_comments_hash = {}
    @comment_subcomments_hash = {}
    @feed_items.each do |micropost|
      @post_comments_hash[micropost.id] = micropost.comments;
      micropost.comments.each do |comment|
        @comment_subcomments_hash[comment.id] = comment.subcomments;
      end
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
