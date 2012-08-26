Refinery::Core::Engine.routes.append do
  namespace :calendar do
    root :to => "events#index"
    
    get 'category/:id' => 'categories#show', :as => 'category'

    resources :events, :path => '', :only => [:show]
    # get 'archive/:year(/:month)' => 'events#archive', :as => 'archive'
    
    # match 'feed.rss', :to => 'events#index', :as => 'rss_feed', :defaults => {:format => "rss"}
    # match 'categories/:id', :to => 'categories#show', :as => 'category'
    # get 'archive/:year(/:month)', :to => 'events#archive', :as => 'archive_events'
  end

  # Admin routes
  
  namespace :calendar, :path => '' do    
    namespace :admin, :path => 'refinery/calendar' do
      resources :events, :except => :show
      resources :places, :except => :show
      resources :categories, :except => :show
    end
  end

end
