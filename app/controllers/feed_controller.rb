class FeedController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      @posts = current_user.feed.order(created_at: :desc)
      @popular_posts = current_user.feed.order(vote_count: :desc)
      @follow_offers = current_user.follow_offer
    end
  end
end
