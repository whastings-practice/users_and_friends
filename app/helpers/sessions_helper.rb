module SessionsHelper

  def current_user
    return nil unless session[:auth_token]
    @current_user ||= User.find_by(:session_token => session[:auth_token])
  end

  def login!
    session[:auth_token] = @user.reset_session_token!
  end

  def logged_in?
    !!current_user
  end

  def logout!
    current_user.reset_session_token!
    session[:auth_token] = nil
  end


  def require_signed_in
    unless current_user
      redirect_to new_session_url
    end
  end

  def require_signed_out
    if current_user
       redirect_to user_url(current_user)
    end
  end


end
