module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
	  @current_user = user
	  token = User.new_token
	  user.update_attribute(:remember_token, token)
	  cookies.permanent[:remember_token] = token
	end
	
	def current_user
	  # For sessions
	  # @current_user ||= User.find_by(id: session[:user_id])

    # For sessions using cookies
	  @current_user ||= User.find_by(remember_token: cookies.permanent[:remember_token])
	end
	
	def current_user=(user)
	  @current_user = user
	end
	
	def logged_in?
	  !current_user.nil?
	end
	
	def log_out
	  session.delete(:user_id)
	  @current_user = nil
	  cookies.permanent[:remember_token] = nil
	end
end
