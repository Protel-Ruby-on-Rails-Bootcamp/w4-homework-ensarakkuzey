class WelcomeController < ApplicationController
  def index
    @posts =  Post.availables
  end
end
