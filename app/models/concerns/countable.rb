module Countable
  def remaining_tasks_count
    tasks.incompleted.count
  end
end