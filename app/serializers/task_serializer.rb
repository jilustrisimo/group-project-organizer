class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :due_date, :completed,
             :updated_at, :user_id, :is_current_user_task,
             :project_id, :is_past_due_date, :user

  belongs_to :user
  belongs_to :project

  def is_current_user_task
    object.user == current_user
  end

  def updated_at
    object.updated_at.strftime('%A, %e %B %Y')
  end

  def due_date
    object.due_date.strftime('%A, %e %B %Y')
  end

  def is_past_due_date
    object.due_date <= Date.tomorrow && object.completed != true
  end

  def user
    object.user.nil? ? nil : object.user.username
  end
end
