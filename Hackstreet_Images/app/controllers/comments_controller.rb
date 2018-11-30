class CommentsController < ApplicationController
    before_action :find_image!

    
  
    def create
        #if user_signed_in?
            @comment = @image.comments.new(comment_params)
            @comment.user_id = current_user

            if @comment.save!
                redirect_back fallback_location: root_path 
            else
                redirect_back fallback_location: root_path, :flash => { :error => "comment not saved!"}
                
            end
        #else
          #  redirect_back fallback_location: root_path, :flash => { :error => "Must be signed in to comment!"}
        #end
    end
  
    private
  
      def comment_params
        params.require(:comment).permit(:content)
      end

      def find_image!
        @image = Image.find(params[:image_id])
      end
end
