json.extract! task, :id, :title, :content, :due_date, :completed, :assignment_id, :created_at, :updated_at
json.url task_url(task, format: :json)
