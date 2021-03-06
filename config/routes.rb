Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :calendar, :path => 'connect' do
    get 'events/archive' => 'events#archive'
    resources :events, :only => [:index, :show]
  end

  # Admin routes
  namespace :calendar, :path => '' do
    namespace :admin, :path => 'refinery/calendar' do
      resources :events, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Frontend routes
  namespace :calendar do
    resources :venues, :only => [:index, :show]
  end

  # Admin routes
  namespace :calendar, :path => '' do
    namespace :admin, :path => 'refinery/calendar' do
      resources :venues, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
