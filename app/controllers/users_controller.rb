class UsersController < ApplicationController
  
  def show
    @user = User.find_by(id: params[:id])  # dùng find nếu ko có giá trị -> trả về lỗi, dùng find_by nếu ko có -> nil
    # binding.pry
    # debugger = binding.pry || byebug
  end
  
  def new
    @user = User.new
  end

  def create
    # binding.pry
    @user = User.new(user_params)    #hàm băm bảo mật cho ng dùng
    if @user.save
      # Handle a successful save.
      sign_in @user
      flash[:success] = "Welcome to the GB App!"
      redirect_to @user               #~redirect_to user_url(@user)
    else
      render 'new'
    end
  end


  def destroy
    sign_out
    redirect_to root_url
  end


  private  #hàm ko cần public do chỉ dùng nội bộ
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)    #cho phép các thuộc tính xác nhận tên, email, mật khẩu và mật khẩu (nhưng không cho phép các thuộc tính khác)
    end
end
