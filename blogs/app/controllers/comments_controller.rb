class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [ :edit, :update, :destroy ]
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]


  def index
    @comments = @post.comments
  end

  def show
    @comment = @post.comments.find(params[:id])
  end

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      format.html {
        if @comment.save
          @comments = Comment.where(post_id: @comment.post_id).order(created_at: :desc)
          redirect_to @post, notice: "Comment was successfully created."
        else
          render "posts/show", status: :unprocessable_entity
        end
      }
    end
  end

  def edit
  end

  def update
    @comment = @post.comments.find(params[:id])
    @comment.statement = comment_params[:statement]
      respond_to do |format|
        if @comment.update(comment_params)
          format.html {
            redirect_to post_path(@post), notice: "Comment was successfully updated."
          }
        else
          format.html {
            redirect_to post_path(@post), alert: "Failed to update comment. Please ensure the statement is not empty."
          }
        end
      end
  end


  def destroy
    @comment.destroy

    redirect_to @post, notice: "Comment deleted successfully.", status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:statement)
  end
end
