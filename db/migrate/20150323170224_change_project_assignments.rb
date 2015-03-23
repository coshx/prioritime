class ChangeProjectAssignments < ActiveRecord::Migration
  def change
    add_column :project_assignments, :start_date, :datetime
    add_column :project_assignments, :end_date, :datetime
    remove_column :project_assignments, :created_at
    remove_column :project_assignments, :updated_at
  end
end
