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

    def set_user_else_redirect
      @user = resolve_correct_user params[:username]
      if @user == :empty
        flash[:invalid_user_error] = "Could not display this user"
        redirect_to root_path
      end

      images_to_display = @user.images
      images_to_display.each do |img|
        images_to_display -= [img] unless user_has_view_permission(img, current_user)
      end
      # now that we've determined which images to display, display them
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

    def user_has_view_permission(img, active_user)
      should_display = true #presume we should show it, until proven otherwise

      if (!active_user.nil? && active_user.id == img.user_id)
        return should_display
      end

      case img.privacy_level
      when "anon_public"
        if active_user
          should_display = false # if the user is signed in, don't show anon pics
        end
      when "anon_private"
        should_display = false # never display anon pics
      when "signed_in_private"
        if active_user
          # we determine if logged in user has permission to see this pic
          image_poster = User.find(img.user_id)
          should_display = false unless current_user.following? image_poster
        else
          should_display = false # don't let anon users see private pics of signed in users
        end
      when "signed_in_public" 
        # always display these, uploader designated them as public
      else
        # Privacy indeterminable. Just show it.
      end
  
      should_display
    end

    private
      def user_params
        params.require(:user).permit(:username, :email)
      end
end
