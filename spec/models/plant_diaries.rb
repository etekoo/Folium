# spec/models/plant_diary_spec.rb
require 'rails_helper'

RSpec.describe PlantDiary, type: :model do
  subject(:plant_diary) { build(:plant_diary) }

  describe 'バリデーションのテスト' do
    it 'タイトルと内容があれば有効であること' do
      expect(plant_diary).to be_valid
    end

    it 'タイトルがないと無効であること' do
      plant_diary.title = nil
      plant_diary.valid?
      expect(plant_diary.errors[:title]).to include("can't be blank")
    end

    it '内容がないと無効であること' do
      plant_diary.content = nil
      plant_diary.valid?
      expect(plant_diary.errors[:content]).to include("can't be blank")
    end
  end

  describe 'メソッドのテスト' do
    it '画像がリサイズされること' do
      plant_diary.image.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_image.jpg')), filename: 'test_image.jpg', content_type: 'image/jpeg')
      variant = plant_diary.resize_diary_image(100, 100, 'fit')
      expect(variant).to be_a(ActiveStorage::Variant)
    end

    it '検索が正しく機能すること' do
      plant_diary.save!
      expect(PlantDiary.looks('perfect_match', plant_diary.title)).to include(plant_diary)
    end
  end
end
