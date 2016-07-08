class PhotosController < ApplicationController
	def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
  end
  
  def new
    @photo = Photo.new
  end

  def create
  	@folder = Folder.find(params[:folder_id])
    # build a photo and pass it into a block to set other attributes
    @photo =  @folder.photos.new(photo_params) do |t|
      t.user_id = @folder.user_id
      if params[:photo][:data]
        t.data      = params[:photo][:data].read
        t.filename  = params[:photo][:data].original_filename
        t.mime_type = params[:photo][:data].content_type
      end
    end
    # normal save
    if @photo.save
      #redirect_to(@photo, :notice => 'Photo was successfully created.')
      redirect_to folders_path
    else
      render :action => "new"
    end
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to(photos_url)
  end

  def serve
    @photo = Photo.find(params[:id])
    send_data(@photo.data, :type => @photo.mime_type, :filename => "#{@photo.name}.jpg", :disposition => "inline")
  end

  private 
		def photo_params
			params.require(:photo).permit(:name,:filename,:mime_type)
		end
end
