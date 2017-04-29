class Project < ApplicationRecord
  has_many :project_teams
  has_many :team_members, through: :project_teams, source: :user
  has_many :tasks, dependent: :destroy

  validates_presence_of :title, :description, :due_date
  validate :due_date_cannot_be_in_the_past

  def tasks_attributes=(tasks_attributes)
    tasks_attributes.delete_if { |_i, h| h.any? { |_k, v| v.empty? } }
    tasks_attributes.values.each { |task| tasks.build(task) }
  end

  def due_date_cannot_be_in_the_past
    errors.add(:due_date, "can't be in the past") if due_date.present? && due_date < Date.today
  end

  def team_member?(user)
    team_members.include?(user)
  end

  def completed?
    if completed
      true
    elsif completed != true && tasks.all?(&:completed?)
      true && update(completed: true)
    else
      false
    end
  end
end
