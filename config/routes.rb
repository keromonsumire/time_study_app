Rails.application.routes.draw do
  get 'sessions/new'
  get 'signup', to:'users#new'
  get 'statictics',to:'statictics#statictics'
  delete '/statictics/:id/destroy', to: 'statictics#destroy'
  get 'contact', to:'home#contact'
  root 'home#home'
  post '/home/create', to: 'home#create'
  post '/home/end', to: 'home#end'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end
