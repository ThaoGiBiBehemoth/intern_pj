class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    # debugger
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    #hàm băm bảo mật cho ng dùng
    if @user.save
      # Handle a successful save.
    else
      render 'new'
    end
  end
  private  #hàm ko cần public do chỉ dùng nội bộ
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)    #cho phép các thuộc tính xác nhận tên, email, mật khẩu và mật khẩu (nhưng không cho phép các thuộc tính khác)
  end
end
