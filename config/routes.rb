Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'works#root'

  resources :works
  post '/works/:id/upvote', to: 'works#upvote', as: 'upvote'

  resources :users, only: [:index, :show]

  get '/auth/:provider/callback', to: "sessions#login"
  post '/logout', to: 'sessions#logout', as: 'logout'
#get or post logout???


  # get "/auth/:provider/callback", to: "sessions#create"
end
