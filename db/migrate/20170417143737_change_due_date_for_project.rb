class ChangeDueDateForProject < ActiveRecord::Migration[5.0]
  def change
    change_column :projects, :due_date, :date
  end
end
