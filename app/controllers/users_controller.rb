class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :previous_events, 
                                        :upcoming_events]

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

  def attended_events
    @user = User.find_by(id: params[:id])
    @attended_events = @user.attended_events.paginate(page: params[:page])
  end

  def previous_events
    @user = User.find_by(id: params[:id])
    @previous_events = @user.previous_events.paginate(page: params[:page])
  end

  def upcoming_events
    @user = User.find_by(id: params[:id])
    @upcoming_events = @user.upcoming_events.paginate(page: params[:page])
  end

  private

    def user_params
      params.require(:user).permit(:name, :username, :email, 
                                   :password, :password_confirmation)
    end
end
