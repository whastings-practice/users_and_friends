class FriendCirclesController < ApplicationController
  before_action :all_other_users, only: [:new, :create, :edit, :update]

  def new
    @friend_circle = FriendCircle.new
    render :new
  end

  def create
    @friend_circle = FriendCircle.new(friend_circle_params)
    @friend_circle.user_id = current_user.id
    # @friend_circle.friend_ids = friend_circle_params[:friend_ids]
    if @friend_circle.save
      redirect_to user_url(current_user)
    else
      fail
      flash.now[:errors] = @friend_circle.errors.full_messages
      render :new
    end
  end

  def edit

  end

  def update

  end

  def index

  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def destroy

  end

  private

  def friend_circle_params
    params.require(:friend_circle).permit({ :friend_ids => [] }, :name)
  end

  def all_other_users
    @other_users = User.where("id <> ?", current_user.id)
  end
end
