class Project < ApplicationRecord
  has_one :project_team
  has_one :project_leader, through: :project_team, source: :user
  has_many :project_members, through: :project_team, source: :user
  has_many :tasks, dependent: :destroy

  validates_presence_of :title, :description, :due_date

  def tasks_attributes=(tasks_attributes)
    tasks_attributes.values.each do |task_attributes|
      tasks.build(task_attributes)
    end
  end
end
