# frozen_string_literal: true

namespace :jia_bo, defaults: { business: 'jia_bo' } do
  namespace :panel, defaults: { namespace: 'panel' } do
    root 'home#index'
    resources :apps do
      resources :devices do
        collection do
          post :sync
        end
        member do
          patch :test
        end
        resources :device_organs
      end
    end
  end
  namespace :admin, defaults: { namespace: 'admin' } do
    root 'home#index'
    resources :device_organs do
      collection do
        post :scan
      end
    end
  end
end
