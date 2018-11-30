class RelationshipsController < ApplicationController
    def index
        @user = find_by(column[:username])
        @user.followers
    end

    def create  #follow button
        @relationship = Relationship.new()
        user = User.find(allowed_params)
        current_user.follow(user)
        redirect_to user
        if @relationship.save
            render show_path
        else
            flash.notice = "Unable to follow at this moment"
        end
    end

    def destroy
        user = Relationship.find(allowed_params).followed
        current_user.unfollow(user)
        redirect_to user
    end

    private
        def allowed_params
            params.require(:relationship).permit(:follower, :followed)
        end

end
