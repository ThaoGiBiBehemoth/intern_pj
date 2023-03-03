class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find_by(id: params[:id])  # dùng find nếu ko có giá trị -> trả về lỗi, dùng find_by nếu ko có -> nil
    @microposts = @user.microposts.paginate(page: params[:page])
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





  def edit
    @user = User.find_by(id: params[:id]) 
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # Handle a successful update.
      flash[:success] = "Information updated!"
      redirect_to @user     
    else
      render 'edit'
    end
  end




  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end




  private  #hàm ko cần public do chỉ dùng nội bộ
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)    #cho phép các thuộc tính xác nhận tên, email, mật khẩu và mật khẩu (nhưng không cho phép các thuộc tính khác)
    end


    # Before filters   #chuyển qua application do micropost cũng dùng
    # Confirms a signed-in user
    # def signed_in_user   # hoặc có thể dùng if nhưng th này dùng unless logic có vẻ thuận hơn, tt như nhau
    #   unless signed_in?
    #     store_location
    #     flash[:danger] = "Please sign in."
    #     redirect_to signin_url
    #   end
    # end


    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)      # ~ redirect_to(root_url) if @user != current_user
    end
end
