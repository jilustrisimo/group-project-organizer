class ProjectTeam < ApplicationRecord
  belongs_to :user
  belongs_to :project

  scope :team_id, (->(user, project) { where('user_id = ? and project_id = ?', user.id.to_s, project.id.to_s) })
end
