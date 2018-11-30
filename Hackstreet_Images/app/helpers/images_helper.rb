#Written by Jalen Soat
module ImagesHelper
    # helper to display the user's avatar
    def display_avatar(user)
        if user.profile_image_datafile.attached?
          user.profile_image_datafile.variant(resize: '150x150x')
        else
          'defaultuser.jpg'
        end
    end

    #check if image is in favorite list
    def favorite_check user, img
      user.favorites.each do |fav|
        if fav.image_id == img.id
          return true
        end
      end

      return false
    end
end