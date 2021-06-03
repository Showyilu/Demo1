class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.boolean :active
      t.boolean :complete

      t.timestamps
    end
  end
end
