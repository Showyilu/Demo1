class AddDefaultValueToActiveAndComplete < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :active, :boolean, default: true
    change_column :tasks, :complete, :boolean, default: false
  end
end
