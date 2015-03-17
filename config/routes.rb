Rails.application.routes.draw do
  scope defaults: { format: 'json' } do
    # Let ember control all html requests
    root 'ember#index'
    # get '*ember' => 'ember#index', constraints: lambda { |request| request.format == "text/html" }

    # /csrf
    get :csrf, to: 'csrf#index'

    # Devise
    devise_for :users, skip: [:registrations], controllers: { sessions: 'sessions' }
    
    resources :organizations, only: [] do
      member do
        get 'dashboard'
      end
    end

    resources :employees, path: ':organization_id/employees'
    resources :projects, path: ':organization_id/projects'
    
    resources :project_assignments do
      collection do
        get 'for_person', path: 'for_person/:person_id'
      end
    end
    
    resources :weekly_project_assignments

    resources :users, only: [:show, :create] do
      collection do
        get 'profile'
      end
    end

    # Only using devise passwords routes
    devise_for :users, skip: [:sessions, :registrations]
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
