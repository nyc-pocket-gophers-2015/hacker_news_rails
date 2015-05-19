class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:warn] = "User could not be saved"
      redirect_to new_user_path
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
