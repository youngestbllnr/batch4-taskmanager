class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :icon
      t.text :description

      t.timestamps
    end
  end
end
