Rails.application.routes.draw do
  resources :games do
    post :play
    post :join
  end

  root "games#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # The best explanation I found for ActionCable/react:
  #  https://javascript.plainenglish.io/integrating-actioncable-with-react-9f946b61556e
  mount ActionCable.server => '/cable'
end
