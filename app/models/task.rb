class Task < ApplicationRecord
  belongs_to :assignment, polymorphic: true

  validates_presence_of :title, :content, :due_date
end
