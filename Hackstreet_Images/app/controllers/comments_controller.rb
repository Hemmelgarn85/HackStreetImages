class CommentsController < ApplicationController
    def new
        @comment = Comment.new
      end
  
      def create
        @comment = Comment.new(comment_params)
  
        if @comment.save
            flash[:notice] = 'Comment Saved Successfully'
            redirect_back fallback_location: root_path
        else
            flash[:notice] = 'Comment Not Saved'
            redirect_back fallback_location: root_path
        end
      end
  
      private
  
      def comment_params
        params.require(:comment).permit(:content)
      end
end
