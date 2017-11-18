class CollaboratorsController < ApplicationController
  
  def new
    @collaborator = Collaborator.new
  end
  
  def create
    @collaborator = Collaborator.new
    @collaborator.user = User.where(username: params[:collaborator][:user]).first 
    @collaborator.wiki = Wiki.where(title: params[:title]).first
    user = User.find_by(username: params[:collaborator][:user])
    @wiki = Wiki.find_by(title: params[:title])
      
    if user
      @collaborator =  Collaborator.where(user: user, wiki: @wiki).first_or_initialize
      if @collaborator.persisted?
        flash[:alert] = 'User is already a collaborator'
        return redirect_to @wiki
      elsif @collaborator.save
        flash.now[:alert] = "#{user} can now collaborate on this wiki"
        redirect_to @wiki
      else
        flash.now[:alert] = "There was an error adding the collaborator. Please try again."
        render :new
      end
    else
      flash[:alert] = 'That user was not found'
      redirect_to @wiki
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
