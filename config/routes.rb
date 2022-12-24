Rails.application.routes.draw do
  get 'sessions/new'
  post 'users/guest_sign_in', to: 'sessions#new_guest'
  get 'signup', to:'users#new'
  get 'statictics',to:'statictics#statictics'
  post '/statictics/up', to: 'statictics#up'
  post '/statictics/down', to: 'statictics#down'
  post 'statictics/point_up', to: 'statictics#point_up'
  post 'statictics/point_down', to: 'statictics#point_down'
  post 'statictics/change_to_month', to: 'statictics#change_to_month'
  post 'statictics/change_to_week', to: 'statictics#change_to_week'
  post 'start/create', to: 'start#create'
  get 'start/:id/edit', to:'start#edit'
  patch 'start/:id/update', to: 'start#update'
  delete '/start/:id/destroy', to: 'start#destroy'
  post 'end/create', to: 'end#create'
  get 'end/:id/edit_memo', to: 'end#edit_memo'
  get 'end/:id/edit', to: 'end#edit'
  patch 'end/:id/update_memo', to: 'end#update_memo'
  patch 'end/:id/update', to: 'end#update'
  get 'contact', to:'home#contact'
  get 'break', to:'home#break'
  root 'home#home'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get   'inquiry', to: 'inquiry#index'     # 入力画面
  post  'inquiry/confirm', to: 'inquiry#confirm'   # 確認画面
  post  'inquiry/thanks', to: 'inquiry#thanks'    # 送信完了画面
  resources :users
end
