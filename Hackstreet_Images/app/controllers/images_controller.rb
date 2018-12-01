# created by Ivan Lavrov
class ImagesController < ApplicationController

  def index
    images_to_display = Array.new

    # if the user is signed in, we should populate their feed with pictures posted by people who they follow
    if user_signed_in?
      current_user.following.each do |user|
        user.images.each do |img|
          images_to_display.push img
        end
      end
    else # if the user is anon, populate feed with public anon pics and public user pics
      images_to_display += Image.where(privacy_level: 0)
      images_to_display +=  Image.where(privacy_level: 2)
    end
    @images = images_to_display
  end

  def new
    @image = Image.new
  end

  def create
    if user_post_params[:image_datafile].nil?
      flash[:nofile] = "Please attach a file"
      redirect_to image_upload_path and return
    end

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

  def destroy
    Image.find(params[:id]).destroy
    flash[:success] = "Photo deleted"
    redirect_to root_url
  end

  def favorite
      @image = Image.find(params[:id])
      @favorite = Favorite.where(image: @image).first
      if @favorite.nil?
        current_user.favorites << Favorite.new(image: @image)
      end
      redirect_back fallback_location: root_path
  end

  def unfavorite
    @image = Image.find(params[:id])
    @favorite = Favorite.where(image: @image).first
    if !@favorite.nil?
      current_user.favorites.delete(@favorite)
    end
    redirect_back fallback_location: root_path
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