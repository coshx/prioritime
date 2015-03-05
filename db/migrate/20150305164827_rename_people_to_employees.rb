class RenamePeopleToEmployees < ActiveRecord::Migration
  def change
    rename_table :people, :employees
    remove_column :employees, :description
    remove_column :employees, :user_id
  end
end
