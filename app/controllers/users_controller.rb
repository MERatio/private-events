class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = 'Account created successfully'
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @events = @user.events.paginate(page: params[:page])
  end

  private

    def user_params
      params.require(:user).permit(:name, :username, :email, 
                                   :password, :password_confirmation)
    end
end
