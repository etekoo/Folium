Rails.application.routes.draw do
  # 顧客用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root 'public/homes#top'                                     # TOPページ

 
  scope module: :public do
    get 'homes/about'                                         # aboutページ
    resources :communities do
      resources :communitymembers, only: [:create, :destroy]  # コミュニティメンバー関連
    end
    resources :comments, only: [:create, :destroy]            # コメント関連
    resources :plant_diaries                                  # プラントダイアリー関連
    resources :users, only: [:show, :edit, :update] do
      get 'mypage', on: :collection
      get 'unsubscribe', on: :member
      delete 'withdraw', on: :member
    end
  end

  namespace :admin do
    resources :communities, only: [:index, :show, :destroy]   # 管理者用コミュニティ関連
    resources :plant_diaries, only: [:index, :show, :destroy] # 管理者用プラントダイアリー関連
    resources :users, only: [:index, :show, :edit, :update]   # 管理者用ユーザー関連
  end
end