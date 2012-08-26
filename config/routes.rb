Refinery::Core::Engine.routes.append do
  namespace :calendar do
    root :to => "events#index"
    
    get 'archive/:year(/:month)' => 'events#archive', :as => 'archive'
    get 'category/:id' => 'categories#show', :as => 'category'

    resources :events, :path => '', :only => [:show]
    
    # match 'feed.rss', :to => 'events#index', :as => 'rss_feed', :defaults => {:format => "rss"}
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
