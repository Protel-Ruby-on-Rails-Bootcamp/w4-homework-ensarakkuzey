class WelcomeController < ApplicationController
  def index
    if current_user
      @posts =  Post.availables.or(current_user.posts)
    end
  end
end
