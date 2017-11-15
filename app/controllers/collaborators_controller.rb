class CollaboratorsController < ApplicationController
  def new
    @collaborator = Collaborator.new
  end
  
  def create
     @collaborator = Collaborator.new
   
     @collaborator.user = User.where(username: params[:collaborator][:user]).first
     @collaborator.wiki = Wiki.where(title: params[:title]).first

     if @collaborator.save
       flash.now[:alert] = "#{@collaborator.user} can now collaborate on this wiki"
           redirect_to wiki_path(@collaborator.wiki)
     else
       flash.now[:alert] = "There was an error adding the collaborator. Please try again."
       render :new
     end
  end

  def destroy
     @collaborator = Collaborator.find(params[:id])

     if @collaborator.destroy
       flash[:notice] = "The collaborator was deleted successfully."
       redirect_to wiki_path(params[:wiki])
     else
       flash.now[:alert] = "There was an error removing the collaborator."
       render :show
     end
  end
end
