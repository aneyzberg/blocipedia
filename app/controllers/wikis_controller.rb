class WikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user)
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(params.required(:wiki).permit(:title, :body))
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the Wiki. Please try again."
      render :edit
    end
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body))
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect to @wiki
    else 
      flash[:error] = "There was an error saving your wiki. Please try again."
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
    flash[:notice] = "The Wiki has been deleted."
    redirect_to wikis_path
    else
    flash[:notice] = "The Wiki has not been deleted. Please try again."
    render :show
    end
  end


end
