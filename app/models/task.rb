class Task < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :project

  validates_presence_of :title, :content, :due_date
  validate :due_date_cannot_be_in_the_past, on: :create

  scope :incompleted, (->() { where(completed: false) })
  scope :incompleted_and_unassigned, (-> () { incompleted.where(user_id: nil) })
  scope :search, (->(search) { where('title ILIKE ? OR content ILIKE ? OR cast(due_date as text) ILIKE ?', "%#{search}%", "%#{search}%", "%#{search}%") })

  def due_date_cannot_be_in_the_past
    errors.add(:due_date, "can't be in the past") if due_date.present? && due_date < Date.today
    errors.add(:due_date, "can't be after its project due date: #{project.due_date.strftime('%A %e %B %Y')}") if due_date.present? && due_date > project.due_date
  end
end
