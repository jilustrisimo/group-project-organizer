class SearchController < ApplicationController

  def index
    term = params[:search]
    @projects = Project.search(term)
    @tasks = Task.search(term)
  end
end
