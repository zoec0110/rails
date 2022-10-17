Rails.application.routes.draw do
  resources :people
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'welcome/say_hello' => 'welcome#say'
  get 'welcome' => 'welcome#index'
  root to: 'welcome#index'
  resources :events
  # Defines the root path route ("/")
  # root "articles#index"
end
