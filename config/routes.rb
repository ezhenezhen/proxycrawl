Rails.application.routes.draw do
  root to: "crawlers#index"

  resources :crawlers do
    member do
      get :crawl
    end
  end
end
