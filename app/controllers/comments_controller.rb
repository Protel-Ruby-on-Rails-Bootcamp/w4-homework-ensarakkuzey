class CommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.expire_date = DateTime.now + 2.days
    @comment.user = current_user

    @user = current_user
    @user_comments = @post.comments.where({user_id: @user.id, accepted: false}).order(created_at: :desc) 
    @comments = @post.comments.accepteds

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: "Comment was successfully created." }
        format.js
        # format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to @post, notice: flash[:danger] = 'Comment title or content can\'t be blank.' }
        format.js
        # format.json { render :show, status: :unprocessable_entity, location: @post}
      end
    end

  end

  def accept
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.update!(accepted: true, action: true)
    redirect_to post_comments_path
  end

  def deny
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.update!(accepted: false)
    redirect_to post_comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
