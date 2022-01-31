Rails.application.routes.draw do
  get 'sessions/new'
  get 'signup', to:'users#new'
  get 'statictics',to:'statictics#statictics'
  get 'contact', to:'home#contact'
  root 'home#home'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end
