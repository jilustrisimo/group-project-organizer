class Task < ApplicationRecord
  belongs_to :assignment, polymorphic: true
end
