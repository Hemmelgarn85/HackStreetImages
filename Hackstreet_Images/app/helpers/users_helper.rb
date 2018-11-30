module UsersHelper
    # helper to display the user's avatar
    def display_avatar(user)
        if user.profile_image_datafile.attached?
          user.profile_image_datafile.variant(resize: '150x150x')
        else
          'defaultuser.jpg'
        end
    end

    def resolve_correct_user name
      us = User.where(username: name)
      if us.length == 1
        return us.first
      else
        return :empty
      end
    end
end
