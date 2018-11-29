module UsersHelper
    def profile_pic_for(user)
        if true
            image_tag("defaultuser.png", alt: user.username, class: "profile-pic") 
        else
            # do nothing for now, we don't have images working yet
        end
    end
end
