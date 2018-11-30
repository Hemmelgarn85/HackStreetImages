class ImagesController < ApplicationController

  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    if user_signed_in?
      #add an image to current user
      @image = current_user.images.build(user_post_params)
    else
      #post image anonymously without connection to a user
      @image = Image.new(user_post_params)
    end

    if @image.save
      redirect_to @image
    else
      render 'new'
    end
  end

  def show
    @image = Image.find(params[:id])
  end


  private
    def user_post_params
      user_params = params.require(:image).permit(:name, :description, :image_datafile)
      user_params[:privacy_level] = params[:image][:privacy_level].to_i
      if(user_signed_in?)
        user_params[:privacy_level] = user_params[:privacy_level]+2
      end
      return user_params
    end
end