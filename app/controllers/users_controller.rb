class UsersController < ApplicationController
  skip_before_action :logged_in?, only: [:create, :log_in, :get_user, :index]
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users, only: [:id, :username]
  end

  def show
    render json: @user, only: [:id, :username]
  end

  def create
    @user = User.new(user_params)
    if @user && @user.valid?
      @user.save
      render json: {
        user: {
          id: @user.id,
          username: @user.username,
        },
        token: JWT.encode({user_id: @user.id}, ENV["JWT_KEY"])
      }, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def log_in
    @user = User.find_by(username: user_params[:username])
    if @user && @user.authenticate(user_params[:password])
      render json: {
        user: {
          id: @user.id,
          username: @user.username
        },
        token: JWT.encode({user_id: @user.id}, ENV["JWT_KEY"])
      }, status: :created, location: @user
    else
      render json: {error: 'Invalid creditials.'}, status: :unprocessable_entity
    end
  end

  def get_user
    @user = self.current_user
    if @user
      render json: @user, only: [:id, :username]
    else
      render json: {error: 'Token Invalid.'}, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private
  
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end
end
