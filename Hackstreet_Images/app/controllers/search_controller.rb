#Written by Michael Hemmelgarn
class SearchController < ApplicationController

  def index
  end
  #created by Michael Hemmelgarn
  def search
    @users = User.ransack(username_cont: params[:q]).result(distinct: true)
    @images = Image.ransack(name_cont: params[:q]).result(distinct: true)

    respond_to do |format|
      format.html {}
      format.json {
        @users = @users.limit(5)
        @images = @images.limit(5)
      }
    end
  end
end
