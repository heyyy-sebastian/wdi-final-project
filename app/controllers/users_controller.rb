class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
     @user = User.new(params[:user])
    if @user.save
    redirect_to "/index"
    else
    redirect_to '/signup'
    end
  end

  private
    def user_params
      params
      .require(:user)
      .permit(:email, :password_digest)
    end
end
