Rails.application.routes.draw do
  get '/', to: 'home#new'
  resources :home
  get '/plays/:id', to: 'plays#show', as: 'plays'
end
