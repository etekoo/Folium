require 'rails_helper'
require 'support/admin_login_helper'

RSpec.describe Admin::UsersController, type: :controller do
  include AdminLoginHelper

  before do
    sign_in_as_admin
  end

  describe 'GET #index' do
    it 'ユーザー一覧を表示すること' do
      get :index
      expect(response).to be_successful
    end

    it 'indexテンプレートを表示すること' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'ユーザーを割り当てること' do
      user = create(:user, is_active: true)
      get :index
      expect(assigns(:users)).to eq([user])
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }

    it 'ユーザーを表示すること' do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end

    it 'showテンプレートを表示すること' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end

    it '@userを割り当てること' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'ユーザーが見つからない場合、ルートパスにリダイレクトすること' do
      get :show, params: { id: 'nonexistent-id' }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to be_present
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }

    it 'ユーザーを編集すること' do
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end

    it 'editテンプレートを表示すること' do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end

    it '@userを割り当てること' do
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }

    context '有効な属性で更新する場合' do
      it 'ユーザーを更新すること' do
        patch :update, params: { id: user.id, user: { name: 'Updated Name' } }
        user.reload
        expect(user.name).to eq('Updated Name')
      end

      # it 'マイページにリダイレクトすること' do
      #   patch :update, params: { id: user.id, user: { name: 'Updated Name' } }
      #   expect(response).to redirect_to(mypage_users_path)
      # end
    end

    context '無効な属性で更新する場合' do
      it 'ユーザーを更新しないこと' do
        patch :update, params: { id: user.id, user: { name: nil } }
        user.reload
        expect(user.name).not_to be_nil
      end

      # it 'editテンプレートを表示すること' do
      #   patch :update, params: { id: user.id, user: { name: nil } }
      #   expect(response).to render_template(:edit)
      # end
    end
  end
  
end
