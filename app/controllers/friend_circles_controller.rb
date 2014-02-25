class FriendCirclesController < ApplicationController
  before_action :require_signed_in
  before_action :all_other_users, only: [:new, :create, :edit, :update]
  before_action :circle_and_friends, only: [:edit, :update]
  before_action :require_correct_user, only: [:edit, :update, :show]

  def new
    @friend_circle = FriendCircle.new
    render :new
  end

  def create
    @friend_circle = FriendCircle.new(friend_circle_params)
    @friend_circle.user_id = current_user.id
    # @friend_circle.friend_ids = friend_circle_params[:friend_ids]
    if @friend_circle.save
      redirect_to friend_circle_url(@friend_circle)
    else
      fail
      flash.now[:errors] = @friend_circle.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @friend_circle.update_attributes(friend_circle_params)
      redirect_to friend_circle_url(@friend_circle)
    else
      fail
      flash.now[:errors] = @friend_circle.errors.full_messages
      render :edit
    end
  end

  def index

  end

  def show
    @friend_circle = FriendCircle.find(params[:id])
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

  def circle_and_friends
    @friend_circle = FriendCircle.find(params[:id])
    @friends = @friend_circle.friends.pluck(:id)
  end

  def require_correct_user
    unless current_user.id == @friend_circle.user_id
      redirect_to new_session_url
    end
  end
end
