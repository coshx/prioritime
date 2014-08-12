class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description, default: ""
      t.integer :duration_weeks, default: 0
      t.datetime :start_date
      t.string :client, default: ""
      t.references :user, index: true

      t.timestamps
    end
  end
end
