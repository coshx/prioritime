class CreateWeeklyProjectAssignments < ActiveRecord::Migration
  def change
    create_table :weekly_project_assignments do |t|
      t.references :project_assignment, index: true
      t.date :week_start
      t.integer :days_working

      t.timestamps
    end
  end
end
