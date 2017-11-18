class WikisController < ApplicationController
  def index
     @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    @collabs = @wiki.collaborators
  end

  def new
    @wiki = Wiki.new
  
  end  

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])

    authorize @wiki

    if @wiki.update(wiki_params)
      if @wiki.private
        flash[:notice] = "Private Wiki was saved. Only you can view this Wiki."
      else
        flash[:notice] = "Wiki was saved."
      end  
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def create
     @wiki = current_user.wikis.new(wiki_params)
     
     if(current_user.premium?)
        @wiki.private = params[:wiki][:private]
      else
        @wiki.private = false
     end  


    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def destroy
     @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end
end

 private
   def wiki_params
     params.require(:wiki).permit(:title, :body, :private)
   end
 
