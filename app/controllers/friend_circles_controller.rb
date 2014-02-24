class FriendCirclesController < ApplicationController
  before_action :all_other_users, only: [:new, :create, :edit, :update]

  def new
    existing_friend_circle = FriendCircle.find_by(user_id: current_user.id)
    if existing_friend_circle
      redirect_to edit_friend_circle_url(existing_friend_circle)
    else
      @friend_circle = FriendCircle.new
      render :new
    end
  end

  def create
    @friend_circle = FriendCircle.new(friend_circle_params)
    @friend_circle.user_id = current_user.id
    # @friend_circle.friend_ids = friend_circle_params[:friend_ids]
    if @friend_circle.save
      redirect_to user_url(current_user)
    else
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
