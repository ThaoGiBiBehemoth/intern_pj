module SessionsHelper
  # Logs in the given user.
  def sign_in(user)
    session[:user_id] = user.id
  end

  # Returns the current signed-in user (if any).
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])   # lấy gtrị nếu không nil
    end
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user && user == current_user
  end

  # Returns true if the user is signed in, false otherwise.
  def signed_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
