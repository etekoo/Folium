Rails.application.routes.draw do

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in" # POSTリクエストに修正
  end

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
    get "search" => "searches#search"
    get 'homes/about'                                         # aboutページ
    resources :communities do
      resources :communitymembers, only: [:create, :destroy]  # コミュニティメンバー関連
    end

    resources :plant_diaries do                                 # プラントダイアリー関連
      resources :comments, only: [:create, :destroy]            # コメント関連
    end

    resources :users, only: [:show, :edit, :update] do
      get 'mypage', on: :collection
      get 'unsubscribe', on: :member
      patch 'withdraw', on: :member
    end
  end

  namespace :admin do
    get "search" => "searches#search"
    resources :communities, only: [:index, :show, :destroy]   # 管理者用コミュニティ関連
    resources :plant_diaries, only: [:index, :show, :destroy] # 管理者用プラントダイアリー関連
    resources :users, only: [:index, :show, :edit, :update]   # 管理者用ユーザー関連
  end
end