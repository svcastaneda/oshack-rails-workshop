class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    if current_user
      redirect_to account_settings_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to account_settings_path
    else
      @errors = @user.errors.full_messages
      render template: 'users/new'
    end
  end

  # def show
  #   user = User.where(username: params[:username]).first
  #   if user.nil? # change to 404
  #     redirect_to root_path
  #   else
  #     @posts = user.posts
  #     render template: 'users/show'
  #   end
  # end

  def edit
    current_user ? (@user = current_user) : (redirect_to login_path)
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to profile_path(@user.profile)
    else
      @errors = @user.errors.full_messages
      render template: 'users/edit'
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end
end
