class CreatePlantDiaryTags < ActiveRecord::Migration[6.1]
  def change
    create_table :plant_diary_tags do |t|
      t.references :plant_diary, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
    add_index :plant_diary_tags, [:plant_diary_id, :tag_id], unique: true
  end
end