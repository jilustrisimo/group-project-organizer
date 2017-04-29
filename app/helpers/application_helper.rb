module ApplicationHelper
  def set_project_team
    @team = ProjectTeam.team_id(current_user, @project).pluck(:id).join
  end
end
