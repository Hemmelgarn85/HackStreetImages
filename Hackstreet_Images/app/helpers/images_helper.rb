module ImagesHelper
    # helper to display the user's avatar
    def display_avatar(user)
        if user.profile_image_datafile.attached?
          user.profile_image_datafile.variant(resize: '150x150x')
        else
          'defaultuser.jpg'
        end
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
end