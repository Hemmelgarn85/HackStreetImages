class UsersController < ApplicationController
    #File Created By Michael Hemmelgarn
    def home
        if user_signed_in?
            @user = current_user
            @images = Image.all
        else
            redirect_to images_path
        end
    end

    def edit
      @user = current_user
    end

    #Created by michael Hemmelgarn to allow users to change password
    def update_password
      @user = current_user
      if @user.update(user_params)
        #sign in user
        bypass_sign_in(@user)
        redirect_to root_path
      else
        render "edit"
      end
    end

    def show
      @user =  User.find(params[:id])
    end

    private
      def user_params
        params.require(:user).permit(:username, :email)
      end
end
