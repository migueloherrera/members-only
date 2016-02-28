class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_user_in
      redirect_to @user
    else
      flash.now[:danger] = "Invalid email/password combination"
			render :new
    end
  end
  
  def destroy
    @current_user = nil
    cookies.permanent[:remember_token] = nil
    redirect_to root_path
  end
end
