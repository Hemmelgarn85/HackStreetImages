class ImagesController < ApplicationController

  def index
    images_to_display = Image.all

    images_to_display.each do |img|
      case img.privacy_level
      when "anon_public"
        if user_signed_in?
          images_to_display -= [img] # if the user is signed in, don't show anon pics
        end
      when "anon_private"
        images_to_display -= [img] # never display anon pics
      when "signed_in_private"
        if user_signed_in?
          # we determine if logged in user has permission to see this pic
        else
          images_to_display -= [img] # don't let anon users see private pics of signed in users
        end
      when "signed_in_public" 
        # always display these, uploader designated them as public
      else
        # Privacy indeterminable. Just show it.
      end
    end

    @images = images_to_display
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