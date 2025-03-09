# frozen_string_literal: true
Rails.application.routes.draw do
  scope RailsCom.default_routes_scope do

    namespace :print, defaults: { business: 'print' } do
      namespace :panel, defaults: { namespace: 'panel' } do
        root 'home#index'
        resources :jia_bo_apps do
          resources :jia_bo_printers do
            collection do
              post :sync
            end
            member do
              patch :test
            end
          end
        end
      end
      namespace :admin, defaults: { namespace: 'admin' } do
        root 'home#index'
        resources :devices do
          collection do
            post :scan
          end
        end
        resources :jia_bo_printers
        resources :ip_printers
      end
    end

  end
end
