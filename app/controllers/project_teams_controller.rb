class ProjectTeamsController < ApplicationController

  def create
    @project = Project.find(params[:format])
    @project.team_members << current_user
    redirect_to @project, notice: "You Successfully joined #{@project.title}"
  end

  def destroy
    pt = ProjectTeam.find(params[:id])
    current_user.tasks.where('project_id = ?', pt.project_id.to_s).update_all(user_id: nil)
    pt.destroy
    redirect_to projects_path, notice: 'Successfully left project'
  end
end
