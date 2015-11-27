class CreateCurrentGroup < ActiveRecord::Migration
  def change
    create_table :current_groups do |t|
    	t.integer :user_id
    	t.integer :group_id

    	t.timestamps null: false
    end

    add_index :current_groups, :user_id, unique: true
  end
end
