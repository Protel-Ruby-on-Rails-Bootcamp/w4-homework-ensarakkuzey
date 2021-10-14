class WelcomeController < ApplicationController
  def index
    if current_user
      @posts =  Post.availables.order(created_at: :desc)
    end
  end
end
