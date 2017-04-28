class ProjectTeam < ApplicationRecord
  belongs_to :user
  belongs_to :project

  def self.find_team_id(user, project)
    t = where('user_id = ? and project_id = ?', user.id.to_s, project.id.to_s)
    t.pluck(:id).join
  end
end
