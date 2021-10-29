class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :logged_user, only: %i[ edit update delete ]

  # GET /posts or /posts.json
  def index
    @posts = Post.availables
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comments = @post.comments.accepteds
    @user = current_user
    @user_comments = @post.comments.where({user_id: @user.id, accepted: false}).order(created_at: :desc) 
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def create_bookmark 
    @post = Post.find(params[:id])
    Bookmark.where(post: @post, user: current_user).first_or_create

    respond_to do |format|
      format.html { redirect_to @post }
    end
  end

  def delete_bookmark 
    @post = Post.find(params[:id])
    @bookmark = current_user.bookmarks.where(post: @post)

    if @bookmark != nil
      @bookmark.destroy(@bookmark.ids.first)
    end

    respond_to do |format|
      format.html { redirect_to @post }
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def logged_user
    unless current_user == @post.user
      flash[:danger] = 'You do not have permission to edit this post.'
      redirect_to new_user_session_path
    end
  end

  def vote_control
    @post = Post.find(params[:id])
    
    vote_type = params[:vote_type]
    if vote_type == 'Vote_Up'
      @post.update!(vote_count: @post.vote_count + 1)
    else
      @post.update!(vote_count: @post.vote_count - 1)
    end

    respond_to do |format|
        format.html { redirect_to @post }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :visible)
    end
end
