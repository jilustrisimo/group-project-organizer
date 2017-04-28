module ApplicationHelper
  def set_project_team
    @team = ProjectTeam.find_team_id(current_user, @project)
  end
end
