# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :print, defaults: { business: 'print' } do
    namespace :panel, defaults: { namespace: 'panel' } do
      root 'home#index'
      resources :mqtt_apps
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
      resources :devices
      resources :jia_bo_printers do
        collection do
          post :scan
        end
      end
      resources :printers
    end
  end
end
