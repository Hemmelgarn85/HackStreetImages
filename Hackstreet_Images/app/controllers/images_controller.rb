# created by Ivan Lavrov
class ImagesController < ApplicationController

  def index
    images_to_display = Image.all

    #by Graham Tschieder
    images_to_display.each do |img|
      images_to_display -= [img] unless user_has_view_permission(img, current_user)
    end
    # now that we've determined which images to display, display them
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


  def user_has_view_permission(img, active_user)
    should_display = true #presume we should show it, until proven otherwise

    if (!active_user.nil? && active_user.id == img.user_id)
      return should_display
    end

    case img.privacy_level
    when "anon_public"
      if active_user
        should_display = false # if the user is signed in, don't show anon pics
      end
    when "anon_private"
      should_display = false # never display anon pics
    when "signed_in_private"
      if active_user
        # we determine if logged in user has permission to see this pic
        image_poster = User.find(img.user_id)
        should_display = false unless current_user.following? image_poster
      else
        should_display = false # don't let anon users see private pics of signed in users
      end
    when "signed_in_public" 
      # always display these, uploader designated them as public
    else
      # Privacy indeterminable. Just show it.
    end

    should_display
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