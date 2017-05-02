class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
