class RegistrationsController < Devise::RegistrationsController

    private
      # allow for username property, which isn't built into devise
      def sign_up_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
      end
  
      # enable support for other custom params
      def account_update_params
        params.require(:user).permit(:username, :bio, :email, :password, :password_confirmation, :current_password, :full_name, :profile_image_datafile)
      end
end