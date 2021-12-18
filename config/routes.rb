Rails.application.routes.draw do
  get 'top',to:'statictics#top'
  root 'home#home'
end
