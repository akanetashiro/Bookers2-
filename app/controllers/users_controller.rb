class UsersController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update]
    
  def show
    @user = User.find(current_user.id) 
    @books = @user.books
  end
  
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id]) 
    if @user.update
     flash[:pfupdate] = "You have updated user successfully."
     redirect_to user_path(user.id)
    else
     render:edit
    end
    
    def update
      @user = User.find(params[:id])
      @user.update(user_params)
      redirect_to user_path(@user.id)
      
    end 
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to post_images_path
    end
  end

end 