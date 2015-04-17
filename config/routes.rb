Rails.application.routes.draw do

  resources :users, except: [:index]
  resource :session, only: [:create, :destroy, :new]

  resources :subs, except: [:destroy]
  resources :posts, except: [:index, :destroy]

end
