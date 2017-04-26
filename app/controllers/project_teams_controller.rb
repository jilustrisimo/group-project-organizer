class ProjectTeamsController < ApplicationController

  def create
    @project = Project.find(params[:format])
    @project.project_members << current_user
    redirect_to projects_path, notice: "You Successfully joined #{@project.title}"
  end
end