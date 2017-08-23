Rails.application.routes.draw do
  get '/', to: 'home#new'
  resources :home
end
