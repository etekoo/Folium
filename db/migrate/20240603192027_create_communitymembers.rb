class CreateCommunitymembers < ActiveRecord::Migration[6.1]
  def change
    create_table :communitymembers do |t|

      t.integer :user_id, null: false
      t.integer :community_id, null: false
      t.timestamps
    end
  end
end
