class PostsController < ApplicationController
  before_filter :authenticate, only: [:new, :create]
  
  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path      
    else
      render :new
    end
  end
  
  private
    def authenticate
      unless logged_in?
        redirect_to login_path
      end
    end
    
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
