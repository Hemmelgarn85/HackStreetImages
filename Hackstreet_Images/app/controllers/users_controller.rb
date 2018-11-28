class UsersController < ApplicationController

    def home
        if user_signed_in?
            @images = Image.all
        else
            redirect_to images_path
        end
    end

    def show
    end

end
