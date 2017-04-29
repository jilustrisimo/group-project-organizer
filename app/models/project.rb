class Project < ApplicationRecord
  has_many :project_teams
  has_many :team_members, through: :project_teams, source: :user
  has_many :tasks, dependent: :destroy

  validates_presence_of :title, :description, :due_date

  def tasks_attributes=(tasks_attributes)
    tasks_attributes.delete_if { |_i, h| h.any? { |_k, v| v.empty? } }
    tasks_attributes.values.each { |task| tasks.build(task) }
  end

  def team_member?(user)
    team_members.include?(user)
  end

  def completed?
    tasks.all?(&:completed?)
  end
end
