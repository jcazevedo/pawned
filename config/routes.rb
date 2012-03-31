Pawned::Application.routes.draw do


  # route for the user profile
  match "profile" => "profile#show", :as => :profile

  # route for the user's upcoming matches
  match "matches" => "upcoming_matches#show"

  # route for all open, ongoing tournaments
  match "tournaments/open" => "tournaments#open", :as => :open_tournaments
  match "tournaments/ongoing" => "tournaments#ongoing", :as => :ongoing_tournaments

  match "ratings" => "ratings#index", :as => :ratings

  # I don't know what the hell I'm doing
  # But still: players > tournaments (they admin)
  match "players/:id/tournaments" => "players#tournaments", :as => :player_tournaments

  # nested routing for tournaments > rounds > duels > matches
  # and routing for tournaments > rounds > standings
  resources :tournaments do
    resources :rounds do
      resources :duels do
        resources :matches
      end
      resources :standings
    end
  end

  # participations routes so players can ingress tournaments
  resources :participations, :only => [:create, :destroy]

  # the admin namespace: players administration, app settings, etc..
  namespace :admin do
    resources :players
  end

  # devise authentication for players
  devise_for :players

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
