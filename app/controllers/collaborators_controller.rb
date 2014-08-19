class CollaboratorsController < ApplicationController
  before_action :set_wiki
  def index
    @users = User.all
  end

  def create
  end

  def destroy
  end

  private 

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
