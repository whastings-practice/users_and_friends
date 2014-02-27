class UsersController < ApplicationController
  before_action :require_signed_in,
                :only => [:edit, :update, :destroy, :shared_posts_feed]
  before_action :require_correct_user, :only => [:edit, :update, :destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def index

  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @circles = @user.friend_circles
    render :show
  end

  def destroy

  end

  def reset_password
    render :reset_password
  end

  def send_reset_email
    @user = User.find_by(email: user_params[:email])
    if @user
      password_reset = UserResetPassword.create!(:user_id => @user.id)
      mail = UserMailer.password_reset_email(password_reset, @user)
      mail.deliver!

    end
    flash[:notice] = "Password reset email has been sent"
    redirect_to new_session_url
  end

  def new_password
    reset_password = UserResetPassword.find_by(:auth_token => params[:q])
    unless reset_password && !reset_password.expired?
      flash[:notice] = "Invalid reset token."
      redirect_to new_session_url
      return
    end
    @user = reset_password.user
    login!
    flash[:notice] = 'Please reset your password.'
    reset_password.destroy
    redirect_to edit_user_url(@user)
  end

  def shared_posts_feed
    @posts = current_user.posts_shared_with_user
    render :feed
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def require_correct_user
    unless current_user.id == params[:id].to_i
      redirect_to new_session_url
    end
  end

end
