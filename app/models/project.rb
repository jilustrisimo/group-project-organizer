class Project < ApplicationRecord
  has_many :project_teams, dependent: :destroy
  has_many :team_members, through: :project_teams, source: :user
  has_many :tasks, dependent: :destroy

  validates_presence_of :title, :description, :due_date
  validate :due_date_cannot_be_in_the_past, on: :create

  scope :search, (->(search) { where('title ILIKE ? OR description ILIKE ? OR cast(due_date as text) ILIKE ?', "%#{search}%", "%#{search}%", "%#{search}%") })

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
    if completed && !tasks.all?(&:completed) && tasks.count > 0
      update(completed: false)
    elsif !completed && tasks.all?(&:completed) && tasks.count > 0
      update(completed: true)
    else
      completed
    end
  end
end
