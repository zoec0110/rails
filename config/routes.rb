Rails.application.routes.draw do
  resources :people
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'welcome/say_hello' => 'welcome#say'
  get 'welcome' => 'welcome#index'
  root to: 'welcome#index'
  resources :events do
    resources :attendees, controller: 'event_attendees'
    resource :location, controller: 'event_locations'
  end
  resources :events do
    collection do
      get :latest
      post :bulk_delete
    end
  end
  # match ':controller(/:action(/:id(.:format)))', via: :all
  # Defines the root path route ("/")
  # root "articles#index"
end
