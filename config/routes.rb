Rails.application.routes.draw do

  scope module: :public do
    root :to => 'homes#top'
    get 'about' => 'homes#about'

    resource :customers, only: [:edit, :update] do
     get 'mypage' => 'customers#show'
     get 'unsubscribe' => 'customers#unsubscribe'
     patch 'withdraw' => 'customers#withdraw'
   end

   resources :profiles do
     resource :favorites, only: [:create, :destroy]
     resources :profile_comments, only: [:create, :destroy]
   end

   resources :posts
   get "search_post" => "posts#search_post"

   #会員用
   devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
   }
  end


  #管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
