class CreateCommunities < ActiveRecord::Migration[6.1]
  def change
    create_table :communities do |t|

      t.integer :user_id, null: false
      t.integer :owner_id
      t.string  :name, null: false
      t.text    :introduction, null: false
      t.timestamps
    end
  end
end
