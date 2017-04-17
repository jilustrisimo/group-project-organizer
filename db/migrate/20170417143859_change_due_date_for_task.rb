class ChangeDueDateForTask < ActiveRecord::Migration[5.0]
  def change
    change_column :tasks, :due_date, :date
  end
end
