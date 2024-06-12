require 'rails_helper'

RSpec.describe Public::UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:guest_user) { create(:user, email: User::GUEST_USER_EMAIL) }

  before do
    sign_in user
  end

  describe 'GET #mypage' do
    it 'マイページにアクセスできること' do
      get :mypage, params: { id: user.id }
      expect(response).to be_successful
    end

    it 'マイページが表示されること' do
      get :mypage, params: { id: user.id }
      expect(response).to render_template(:mypage)
    end
  end

  describe 'GET #edit' do
    it '編集ページにアクセスできること' do
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end

    it '編集ページが表示されること' do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context '正しい属性値が与えられた場合' do
      it 'ユーザー情報が更新されること' do
        patch :update, params: { id: user.id, user: { name: 'Updated Name' } }
        user.reload
        expect(user.name).to eq('Updated Name')
      end

      it 'マイページにリダイレクトされること' do
        patch :update, params: { id: user.id, user: { name: 'Updated Name' } }
        expect(response).to redirect_to(mypage_users_path)
      end
    end

    context '不正な属性値が与えられた場合' do
      it 'ユーザー情報が更新されないこと' do
        patch :update, params: { id: user.id, user: { name: nil } }
        user.reload
        expect(user.name).not_to be_nil
      end

      it '編集ページが表示されること' do
        patch :update, params: { id: user.id, user: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'POST #withdraw' do
    it 'ユーザーが非アクティブ化されること' do
      post :withdraw, params: { id: user.id }
      user.reload
      expect(user.is_active).to be_falsey
    end

    it 'セッションがリセットされること' do
      expect(controller).to receive(:reset_session)
      post :withdraw, params: { id: user.id }
    end

    it 'ルートパスにリダイレクトされること' do
      post :withdraw, params: { id: user.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #show" do
    it "ユーザーの詳細ページにアクセスできること" do
      user = create(:user)
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end

    it "ユーザーの詳細ページが表示されること" do
      user = create(:user)
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end
end