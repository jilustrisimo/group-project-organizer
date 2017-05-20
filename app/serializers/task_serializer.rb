class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :due_date, :completed,
             :updated_at, :user_id, :is_current_user_task

  belongs_to :user
  belongs_to :project

  def is_current_user_task
    object.user == current_user
  end
end
