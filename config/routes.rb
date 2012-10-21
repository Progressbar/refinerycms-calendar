Refinery::Core::Engine.routes.append do
  namespace :calendar do
    root :to => 'events#index'

    get 'archive/:year(/:month)' => 'events#archive', :as => 'archive'
    get 'category/:id' => 'categories#show', :as => 'category'
    get 'place/:id' => 'places#show', :as => 'place'

    resources :events, :path => '', :only => [:show]

  end

  # Admin routes

  namespace :calendar, :path => '' do
    namespace :admin, :path => 'refinery/calendar' do
      root :to => "events#index"

      resources :events, :except => :show
      resources :places, :except => :show
      resources :categories, :except => :show
    end
  end

end
