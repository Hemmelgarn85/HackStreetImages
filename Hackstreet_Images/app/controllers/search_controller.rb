#Written by Michael Hemmelgarn
class SearchController < ApplicationController

  def index
  end
  #created by Michael Hemmelgarn Queries the database for users and images based on what the user entered
  def search
    @users = User.ransack(username_cont: params[:q]).result(distinct: true)
    @images = Image.ransack(name_cont: params[:q]).result(distinct: true)
    #depending on the url format it will limit the number of posts to a resonable number for the dropdown
    respond_to do |format|
      format.html {}
      format.json {
        @users = @users.limit(5)
        @images = @images.limit(5)
      }
    end
  end
end
