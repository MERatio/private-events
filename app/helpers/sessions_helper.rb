module SessionsHelper
  # Set sesion based on user.id
  def log_in(user)
    session[:user_id] = user.id
  end

  # Persist the user session with cookie
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns the current user based session or session cookie
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end

  # Returns true if there is a current_user
  def logged_in?
    !current_user.nil?
  end

  # Delete hash version of remember_token from db and all session cookies 
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Remove all session cookies, session and current_user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
