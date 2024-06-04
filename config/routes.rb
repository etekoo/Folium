Rails.application.routes.draw do

  # 顧客用
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  get 'communities/index'
  get 'communities/show'
  get 'communities/destroy'
end
namespace :admin do
  get 'plant_diaries/index'
  get 'plant_diaries/show'
  get 'plant_diaries/destroy'
end
namespace :admin do
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
end
namespace :public do
  get 'communities/new'
  get 'communities/index'
  get 'communities/show'
  get 'communities/create'
  get 'communities/edit'
  get 'communities/update'
  get 'communities/destroy'
end
namespace :public do
  get 'communitymembers/create'
  get 'communitymembers/destroy'
end

namespace :public do
  get 'comments/create'
  get 'comments/destroy'
end

namespace :public do
  get 'plant_diaries/new'
  get 'plant_diaries/index'
  get 'plant_diaries/show'
  get 'plant_diaries/create'
  get 'plant_diaries/edit'
  get 'plant_diaries/update'
  get 'plant_diaries/destroy'
end

namespace :public do
  get 'users/mypage'
  get 'users/edit'
  get 'users/show'
  get 'users/update'
  get 'users/unsubscribe'
  get 'users/withdraw'
end

namespace :public do
  get 'homes/top'
  get 'homes/about'
end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
