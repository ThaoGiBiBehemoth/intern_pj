Rails.application.routes.draw do
  
  # root 'application#hello'
  root 'static_pages#home'

  get '/home', to: 'static_pages#home' 
  get '/help', to: 'static_pages#help' #, as: 'helf' (khi đó truy cập /help -> chính là helf_path hay vì help_path)
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  
  get '/signup', to: 'users#new'
  

  get '/signin', to:'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  get '/new_micropost', to:'microposts#new'
  
  

  resources :users
  resources :microposts, only: [:create, :destroy]
end