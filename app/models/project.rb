class Project < ApplicationRecord
  has_one :project_team
  has_many :project_members, through: :project_team, source: :user
  has_many :tasks, dependent: :destroy

  validates_presence_of :title, :description, :due_date

  def tasks_attributes=(tasks_attributes)
    tasks_attributes.delete_if { |_i, h| h.any? { |_k, v| v.empty? } }
    tasks_attributes.values.each { |task| tasks.build(task) }
  end
end
