require 'rails_helper'
require 'support/admin_login_helper'

RSpec.describe Admin::PlantDiariesController, type: :controller do
  include AdminLoginHelper

  before do
    sign_in_as_admin
  end

  describe 'GET #index' do
    it '投稿一覧を表示すること' do
      get :index
      expect(response).to be_successful
    end

    it 'indexテンプレートを表示すること' do
      get :index
      expect(response).to render_template(:index)
    end

    it '@plant_diariesを割り当てること' do
      plant_diary = create(:plant_diary, user: create(:user, is_active: true))
      get :index
      expect(assigns(:plant_diaries)).to eq([plant_diary])
    end
  end

  describe 'GET #show' do
    let(:plant_diary) { create(:plant_diary) }

    it '投稿を表示すること' do
      get :show, params: { id: plant_diary.id }
      expect(response).to be_successful
    end

    it 'showテンプレートを表示すること' do
      get :show, params: { id: plant_diary.id }
      expect(response).to render_template(:show)
    end

    it '@commentを割り当てること' do
      get :show, params: { id: plant_diary.id }
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe 'DELETE #destroy' do
    let!(:plant_diary) { create(:plant_diary) }

    it '投稿を削除すること' do
      expect {
        delete :destroy, params: { id: plant_diary.id }
      }.to change(PlantDiary, :count).by(-1)
    end

    it 'admin_plant_diaries_urlにリダイレクトすること' do
      delete :destroy, params: { id: plant_diary.id }
      expect(response).to redirect_to(admin_plant_diaries_url)
    end
  end
  
end
