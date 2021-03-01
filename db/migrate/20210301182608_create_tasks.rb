class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :category, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :due_date
      t.boolean :is_checked, default: false

      t.timestamps
    end
  end
end
