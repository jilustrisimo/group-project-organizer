class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :description, :due_date, :completed, :updated_at

  has_many :project_teams, dependent: :destroy
  has_many :team_members, through: :project_teams, source: :user
  has_many :tasks, dependent: :destroy
end
