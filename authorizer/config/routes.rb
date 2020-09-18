Rails.application.routes.draw do
  scope module: :web do
    scope module: :controllers do
      resources :operations, only: :create
    end
  end
end
