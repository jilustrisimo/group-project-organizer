class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.datetime :due_date
      t.boolean :completed, default: false
      t.references :assignment, polymorphic: true, index: true

      t.timestamps
    end
  end
end