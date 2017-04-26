class ProjectTeamsController < ApplicationController
  before_action :set_project

  def create
    @project.team_members << current_user
    redirect_to projects_path, notice: "You Successfully joined #{@project.title}"
  end

  def destroy
    
  end

  private

  def set_project
    @project = Project.find(params[:format])
  end
end