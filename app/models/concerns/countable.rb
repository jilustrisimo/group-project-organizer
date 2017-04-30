module Countable

  def remaining_tasks_count
    tasks.incompleted.count
  end

  def unassigned_tasks_count
    tasks.incompleted_and_unassigned.count
  end
end