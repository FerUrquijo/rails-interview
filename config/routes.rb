Rails.application.routes.draw do
  namespace :api do
    resources :todo_lists, only: %i[index], path: :todolists do
      resources :todo_items, path: :todoitems
    end
  end

  resources :todo_lists, only: %i[index new show], path: :todolists do
    patch :update_all, on: :member 
  end
end
