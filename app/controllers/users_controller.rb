class UsersController < ApplicationController
  def index
    
  end

  def new
    @user = User.new
  end

  # def edit
  # end

  # def update
  #   if current_user.update(user_params)
  #     redirect_to root_path
  #   else
  #     render :edit
  #   end
  # end


  def show
  end

  # private

  # def user_params
  #   params.require(:user).permit(:name, :email)
  # end
end
