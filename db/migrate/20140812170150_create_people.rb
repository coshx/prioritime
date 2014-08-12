class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :title, default: ""
      t.text :description, default: ""
      t.integer :hour_capacity, default: 0
      t.references :user, index: true

      t.timestamps
    end
  end
end
