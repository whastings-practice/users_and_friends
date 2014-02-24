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


end
