class RemoveWeeklyProjectAssignments < ActiveRecord::Migration
  def change
    drop_table :weekly_project_assignments
  end
end
