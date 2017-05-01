class SearchController < ApplicationController

  def index
    term = params[:search]
    @projects = Project.search(term).ordered
    @tasks = Task.search(term).ordered
  end
end
