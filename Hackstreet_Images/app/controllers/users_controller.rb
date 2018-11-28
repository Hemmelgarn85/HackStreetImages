class UsersController < ApplicationController

    def home
        if user_signed_in?
            @user = current_user
            @images = Image.all
        else
            redirect_to images_path
        end
    end

    def show
    end

    private
      def user_params
        params.require(:user).permit(:username, :email)
      end
end
