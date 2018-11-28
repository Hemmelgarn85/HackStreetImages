class ImagesController < ApplicationController

  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    if user_signed_in?
      @image = current_user.images.build(user_post_params)
    else
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
      params.require(:image).permit(:name, :description, :image_datafile)
    end
end