class FoldersController < ApplicationController
	#before_action :require_login

    def index
    	@folder_root = Folder.where(:user_id => current_user.id, :head => nil)
    end
    def show
		@folder = Folder.find(params[:id])

		@subs = Folder.where(:user_id => current_user.id, :head => @folder.id )
	end
	def new
		@folder= Folder.new
	end

	def edit
		 @folder = Folder.find(params[:id])
	end
	def update
 		@folder = Folder.find(params[:id])
		@folder.update(folder_params)
		redirect_to folders_path
	end
	def create
	if params[:folder_head] != nil
		@folder= current_user.folders.create(folder_params)
        @folder = Folder.find(@folder.id)
        @folder.update(head: params[:folder_head])
	else
	@folder= current_user.folders.create(folder_params)
    end

	if @folder.save
		flash[:success] = "Folder created !"
	else
		flash[:alert] = "Error !"
 	end
    
    if params[:folder_head] != nil
	redirect_to folder_path(params[:folder_head])
    else
	redirect_to folders_path
    end
	end

	def destroy
  		@folder = Folder.find(params[:id])
        
        if @folder.head != nil
        	@folder_sub = Folder.where(:user_id => current_user.id, :head =>@folder.head)
       
        	@folder_sub.each do |folder| 
	        folder.destroy
	        end 
        end
        	
  		@folder.destroy
			#flash[:alert] = "Folder  deleted. Karma  reduced !"
  		redirect_to folders_path
	end
	private
		def folder_params
			params.require(:folder).permit(:foldername,:user_id,:head)
		end
end
