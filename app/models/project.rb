class Project < ApplicationRecord
  has_one :project_team
  has_one :project_leader, through: :project_team, source: :user
  has_many :project_members, through: :project_team, source: :user
  has_many :tasks, as: :assignment

  validates_presence_of :title, :description, :due_date
end
