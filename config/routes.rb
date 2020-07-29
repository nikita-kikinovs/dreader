Rails.application.routes.draw do
  root to: 'home#feed'

  controller :sessions do
    get 'login' => :new
  end

  resource :user, only: %i[show update edit]

  match 'auth/:provider/callback', to: 'sessions#create', via: %i[get post]
  match 'auth/failure', to: redirect('/'), via: %i[get post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: %i[get post]
end
