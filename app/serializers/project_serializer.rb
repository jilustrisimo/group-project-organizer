class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :is_completed, :description,
             :due_date, :completed, :updated_at, :is_team_member

  has_many :project_teams, dependent: :destroy
  has_many :team_members, through: :project_teams, source: :user
  has_many :tasks, dependent: :destroy

  def is_team_member
    object.team_member?(current_user)
  end

  def is_completed
    object.completed?
  end

end
