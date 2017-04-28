class ProjectTeamsController < ApplicationController

  def create
    @project = Project.find(params[:format])
    @project.team_members << current_user
    redirect_to @project, notice: "You Successfully joined #{@project.title}"
  end

  def destroy
    pt = ProjectTeam.find(params[:id])
    tasks = current_user.tasks.where('project_id = ?', pt.project_id.to_s)
    # too many db impacts
    tasks.each do |task|
      task.user = nil
      task.save
    end
    pt.destroy
    redirect_to projects_path, notice: 'Successfully left project'
  end
end
