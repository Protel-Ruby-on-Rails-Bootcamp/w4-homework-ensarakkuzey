class FeedController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      @posts = current_user.feed.order(created_at: :desc)
    end
  end
end
