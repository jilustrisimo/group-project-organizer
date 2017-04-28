class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates_presence_of :title, :content, :due_date

  def completed?
    completed == true
  end
end
