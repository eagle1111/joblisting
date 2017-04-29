Rails.application.routes.draw do
  devise_for :users
  resources :jobs do
    collection do
    get :search
  end
  resources :resumes
end
  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
  end
resources :jobs do
  member do
    post :join
    post :quit
  end
end
namespace :account do
  resources :jobs
end
resources :categories do
	resources :jobs
end
get '/about',to:'about#index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
