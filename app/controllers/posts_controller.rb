class PostsController < ApplicationController
  before_action :require_signed_in
  before_action :get_friend_circles, :only => [:new, :create, :edit, :update]

  def new
    @post = Post.new
    3.times { @post.links.build }
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.links.new(link_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit

  end

  def update


  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def index

  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:title, :body, { :friend_circle_ids => [] })
  end

  def link_params
    params.permit(:links => [:title, :url])
          .require(:links)
          .values
          .reject { |data| data.all? { |key, value| value.blank? } }
  end


  def get_friend_circles
    @circles = current_user.friend_circles
  end
end
