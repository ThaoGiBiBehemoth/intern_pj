class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # if user && user.authenticate(params[:session][:email][:password])
    if user&.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      #flash[:danger] = 'Invalid email/password combination' # không chính xác lắm
      flash.now[:danger] = 'Invalid email/password combination'  # chính xác hơn: hiển thị 1 lần
      render 'new'
    end
  end


  def destroy
    sign_out
    redirect_to root_url
  end
end
