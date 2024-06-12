# spec/system/plant_diaries_spec.rb
require 'rails_helper'

RSpec.describe 'Plant Diaries', type: :system do
  let!(:user) { create(:user) }
  let!(:plant_diary) { create(:plant_diary, user: user) }

  before do
    driven_by(:rack_test)
  end

  describe 'ユーザー認証のテスト' do
    before do
      sign_in user
    end

    context 'ユーザーの作成' do
      it 'ユーザーが正常に作成される' do
        visit new_user_registration_path
        fill_in 'Email', with: Faker::Internet.email
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        fill_in 'Name', with: Faker::Name.name
        fill_in 'Introduction', with: Faker::Lorem.sentence
        click_button 'Sign up'
        expect(page).to have_content 'Welcome! You have signed up successfully.'
      end
    end

    context 'ログインのテスト' do
      it 'ログインが成功する' do
        visit new_user_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
        expect(page).to have_content 'Signed in successfully.'
      end
    end

    context '投稿のテスト' do
      it '植物日記の投稿が成功する' do
        visit new_plant_diary_path
        fill_in 'Title', with: 'New Plant'
        fill_in 'Content', with: 'This is a new plant diary entry.'
        click_button 'Create Plant diary'
        expect(page).to have_content 'Plant diary was successfully created.'
      end

      it '植物日記の投稿が失敗する' do
        visit new_plant_diary_path
        click_button 'Create Plant diary'
        expect(page).to have_content 'error'
      end
    end

    context '一覧表示のテスト' do
      it '植物日記の一覧が表示される' do
        visit plant_diaries_path
        expect(page).to have_content plant_diary.title
        expect(page).to have_content plant_diary.content
      end
    end

    context '詳細表示のテスト' do
      it '植物日記の詳細が表示される' do
        visit plant_diary_path(plant_diary)
        expect(page).to have_content plant_diary.title
        expect(page).to have_content plant_diary.content
      end
    end

    context '編集のテスト' do
      it '植物日記の編集が成功する' do
        visit edit_plant_diary_path(plant_diary)
        fill_in 'Title', with: 'Updated Plant'
        fill_in 'Content', with: 'This is an updated plant diary entry.'
        click_button 'Update Plant diary'
        expect(page).to have_content 'Plant diary was successfully updated.'
      end

      it '植物日記の編集が失敗する' do
        visit edit_plant_diary_path(plant_diary)
        fill_in 'Title', with: ''
        fill_in 'Content', with: ''
        click_button 'Update Plant diary'
        expect(page).to have_content 'error'
      end
    end

    context '削除のテスト' do
      it '植物日記の削除が成功する' do
        visit plant_diaries_path
        expect { click_link 'Destroy', match: :first }.to change(PlantDiary, :count).by(-1)
      end
    end
  end
end