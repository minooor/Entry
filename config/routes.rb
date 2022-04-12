Rails.application.routes.draw do

  scope module: :public do

    #会員用
   devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
   }

    root :to => 'homes#top'
    get 'about' => 'homes#about'

    resources :customers, only: [:edit, :update, :show] do
     get 'unsubscribe' => 'customers#unsubscribe'
     patch 'withdraw' => 'customers#withdraw'
     member do
      get :favorites
    end
   end

   resources :profiles do
     resource :favorites, only: [:create, :destroy]
     resources :profile_comments, only: [:create, :destroy]
   end

   resources :posts
   get "search_post" => "posts#search_post"
   resources :chats, only: [:create, :show, :destroy]
   resources :notifications, only: [:index, :destroy, :update]
   resources :rooms, only: [:index]

  end


  #管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
