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
      format.js {
        if @comment.save
          @comments = Comment.where(post_id: @comment.post_id).order(created_at: :desc)
          render "posts/show", status: :created
        else
          render "posts/show", status: :unprocessable_entity
        end
      }
      format.json {
        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      }
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: "Comment was successfully updated."
    else
      respond_to do |format|
        format.js {
          render js: "alert('Failed to update comment. Please ensure the statement is not empty.');"
        }
        format.html {
          render :edit, status: :unprocessable_entity
        }
        format.json {
          render json: @comment.errors, status: :unprocessable_entity
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
