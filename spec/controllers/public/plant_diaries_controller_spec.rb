require 'rails_helper'

RSpec.describe Public::PlantDiariesController, type: :controller do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, is_active: true, email: 'admin@example.com') }
  let(:plant_diary) { create(:plant_diary, user: user) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it '新規投稿ページにアクセスできること' do
      get :new
      expect(response).to be_successful
    end

    it '新規投稿ページが表示されること' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #index' do
    it '一覧ページにアクセスできること' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it '詳細ページにアクセスできること' do
      get :show, params: { id: plant_diary.id }
      expect(response).to be_successful
    end

    it '詳細ページが表示されること' do
      get :show, params: { id: plant_diary.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context '正しい属性値が与えられた場合' do
      it '新しい植物日記が作成されること' do
        expect {
          post :create, params: { plant_diary: attributes_for(:plant_diary) }
        }.to change(PlantDiary, :count).by(1)
      end

      it '植物日記のページにリダイレクトされること' do
        post :create, params: { plant_diary: attributes_for(:plant_diary) }
        expect(response).to redirect_to(PlantDiary.last)
      end
    end

    context '不正な属性値が与えられた場合' do
      it '新しい植物日記が作成されないこと' do
        expect {
          post :create, params: { plant_diary: attributes_for(:plant_diary, title: nil) }
        }.not_to change(PlantDiary, :count)
      end

      it '新規投稿ページが表示されること' do
        post :create, params: { plant_diary: attributes_for(:plant_diary, title: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context '正しい属性値が与えられた場合' do
      it '植物日記が更新されること' do
        patch :update, params: { id: plant_diary.id, plant_diary: { title: 'Updated Title' } }
        plant_diary.reload
        expect(plant_diary.title).to eq('Updated Title')
      end

      it '植物日記のページにリダイレクトされること' do
        patch :update, params: { id: plant_diary.id, plant_diary: { title: 'Updated Title' } }
        expect(response).to redirect_to(plant_diary)
      end
    end

    context '不正な属性値が与えられた場合' do
      it '植物日記が更新されないこと' do
        patch :update, params: { id: plant_diary.id, plant_diary: { title: nil } }
        plant_diary.reload
        expect(plant_diary.title).not_to be_nil
      end

      it '編集ページが表示されること' do
        patch :update, params: { id: plant_diary.id, plant_diary: { title: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it '植物日記が削除されること' do
      plant_diary = create(:plant_diary, user: user)
      expect {
        delete :destroy, params: { id: plant_diary.id }
      }.to change(PlantDiary, :count).by(-1)
    end

    it 'マイページにリダイレクトされること' do
      delete :destroy, params: { id: plant_diary.id }
      expect(response).to redirect_to(mypage_users_path)
    end
  end
end
