class RenameUserIdToOrganizationId < ActiveRecord::Migration
  def change
    rename_column :projects, :user_id, :organization_id
  end
end
