class RenamePersonIdToEmployeeId < ActiveRecord::Migration
  def change
    rename_column :project_assignments, :person_id, :employee_id
  end
end
