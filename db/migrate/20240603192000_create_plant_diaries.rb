class CreatePlantDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :plant_diaries do |t|

      t.integer :user_id, null: false
      t.string :title, null: false
      t.text   :content, null: false
      t.timestamps
    end
  end
end
