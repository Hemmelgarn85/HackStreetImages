#Added by Nick Nitta
class RelationshipsController < ApplicationController

    #action to create following relationship
    def create
        user = User.find(params[:followed_id])
        current_user.follow(user)
        redirect_to show_path(user.username)
    end

    def destroy
        user = Relationship.find(params[:id]).followed
        current_user.unfollow(user)
        redirect_to show_path(user.username)
    end

    # private
    #     def allowed_params
    #         params.require(:relationship).permit(:follower, :followed)
    #     end
end