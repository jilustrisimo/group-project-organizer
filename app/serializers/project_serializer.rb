class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :completed?, :description, :due_date, :completed, :updated_at, :team_member?

  has_many :project_teams, dependent: :destroy
  has_many :team_members, through: :project_teams, source: :user
  has_many :tasks, dependent: :destroy

  def team_member?
    object.team_member?(current_user)
  end
end
