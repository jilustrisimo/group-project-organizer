class Project < ApplicationRecord
  has_one :project_team
  has_one :project_leader, through: :project_team, source: :user
  has_many :project_members, through: :project_team, source: :user
  has_many :tasks

  validates_presence_of :title, :description, :due_date
  accepts_nested_attributes_for :tasks

  # def tasks_attributes=(tasks_attributes)
  #   tasks_attributes.each do |task_attributes|
  #     tasks.build(task_attributes)
  #   end
  # end
end
