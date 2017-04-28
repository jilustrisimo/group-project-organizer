class ProjectTeamsController < ApplicationController

  def create
    @project = Project.find(params[:format])
    @project.team_members << current_user
    redirect_to projects_path, notice: "You Successfully joined #{@project.title}"
  end

  def destroy
    ProjectTeam.find(params[:id]).destroy
    redirect_to projects_path, notice: 'Successfully left project'
  end
end
