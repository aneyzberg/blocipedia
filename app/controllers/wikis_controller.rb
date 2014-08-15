class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(params.required(:wiki).permit(:title, :bdoy))
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the Wiki. Please try again."
      render :edit
    end
  end

  def create
    @wiki = Wike.new(params.require(:wiki).permit(:title, :body)
    if wiki.save
      flash[:notice] = "Wiki was saved."
      redirect to @wiki
    else 
      flash[:error] = "There was an error saving your wiki. Please try again."
    end
  end


end
