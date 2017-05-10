class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :description, :due_date, :completed
end
