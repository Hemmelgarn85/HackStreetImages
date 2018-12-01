class UsersController < ApplicationController
    #File Created By Michael Hemmelgarn
    include UsersHelper

    def home
        if user_signed_in?
            @user = current_user
            @images = Image.all
        else
            redirect_to images_path
        end
    end

    # should only reach edit when you're trying to edit your own acct
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

    #by Ivan Lavrov
    def set_user_else_redirect
      @user = resolve_correct_user params[:username]
      if @user == :empty
        flash[:invalid_user_error] = "Could not display this user"
        redirect_to root_path
      end

      # when viewing a user's page, always render thumbnails for their public images
      images_to_display = Array.new   
      images_to_display += @user.images.select { |img| img.signed_in_public? }

      # only render thumbnails for private images if signed in user follows them
      if user_signed_in? && current_user.following?(@user)
        images_to_display += @user.images.select { |img| img.signed_in_private? }
      end

      @images = images_to_display
    end

    def show
      set_user_else_redirect
    end

    def followers
      set_user_else_redirect
    end

    def following
      set_user_else_redirect
    end

    private
      def user_params
        params.require(:user).permit(:username, :email)
      end
end
