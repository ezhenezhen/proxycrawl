Rails.application.routes.draw do
  resources :proxies
  root to: "crawlers#index"

  resources :crawlers do
    member do
      get :crawl
      get :file
    end
  end
end
