Rails.application.routes.draw do
  resources :crawlers
  resources :proxies
  root to: "crawlers#index"

  resources :crawlers do
    member do
      get :crawl
      get :file
      get :send_file_to_admin
    end
  end
end
