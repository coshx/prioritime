class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :user_id
      t.integer :organization_id
      t.actable
    end

    add_index :roles, :user_id
    add_index :roles, :organization_id
  end
end
