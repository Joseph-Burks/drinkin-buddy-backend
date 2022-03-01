class UsersController < ApplicationController
  skip_before_action :logged_in?, only: [:create, :log_in, :get_user, :index]
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users, only: [:id, :username, :is_maker?, :name, :address]
  end

  def show
    render json: @user, only: [:id, :username, :is_maker?, :name, :address]
  end

  def create
    @user = User.new(user_params)
    if @user && @user.valid?
      @user.save
      if @user.is_maker?
        render json: {user: {id: @user.id, username: @user.username, isMaker:@user.is_maker?, name: @user.name, address: @user.address}, token: JWT.encode({user_id: @user.id}, ENV["JWT_KEY"])}, status: :created, location: @user
      else
        render json: {user: {id: @user.id, username: @user.username, isMaker:@user.is_maker?}, token: JWT.encode({user_id: @user.id}, ENV["JWT_KEY"])}, status: :created, location: @user
      end
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def log_in
    @user = User.find_by(username: user_params[:username])
    if @user && @user.authenticate(user_params[:password])
      if @user.is_maker?
        render json: {user: {id: @user.id, username: @user.username, is_maker?:@user.is_maker?, name: @user.name}, token: JWT.encode({user_id: @user.id}, ENV["JWT_KEY"])}, status: :created, location: @user
      else
        render json: {user: {id: @user.id, username: @user.username, is_maker?:@user.is_maker?}, token: JWT.encode({user_id: @user.id}, ENV["JWT_KEY"])}, status: :created, location: @user
      end    else
      render json: {error: 'Invalid creditials.'}
    end
  end

  def get_user
    @user = self.current_user
    render json: @user, only: [:id, :username]
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
      params.require(:user).permit(:username, :password, :is_maker?, :name, :address)
    end
end