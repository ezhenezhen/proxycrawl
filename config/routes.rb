Rails.application.routes.draw do
  root to: "crawlers#index"

  resources :crawlers
end
