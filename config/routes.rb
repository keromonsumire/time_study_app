Rails.application.routes.draw do
  get 'signup', to:'users#new'
  get 'statictics',to:'statictics#statictics'
  get 'contact', to:'home#contact'
  root 'home#home'
end
