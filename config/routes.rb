Rails.application.routes.draw do
  get 'sessions/new'
  get 'signup', to:'users#new'
  get 'statictics',to:'statictics#statictics'
  get 'start/:id/edit', to:'start#edit'
  patch 'start/:id/update', to: 'start#update'
  delete '/start/:id/destroy', to: 'start#destroy'
  get 'end/:id/edit', to: 'end#edit'
  patch 'end/:id/update', to: 'end#update'
  get 'contact', to:'home#contact'
  root 'home#home'
  post '/home/create', to: 'home#create'
  post '/home/end', to: 'home#end'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end
