module CommentsHelper
    # helper to display the user's avatar
    def display_avatar(user)
        if user.profile_image_datafile.attached?
          user.profile_image_datafile.variant(resize: '150x150x')
        else
          'defaultuser.png'
        end
    end
end
