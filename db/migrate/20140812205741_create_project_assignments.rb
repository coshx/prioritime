class CreateProjectAssignments < ActiveRecord::Migration
  def change
    create_table :project_assignments do |t|
      t.references :person, index: true
      t.references :project, index: true
      t.string :summary, default: ""

      t.timestamps
    end
  end
end
