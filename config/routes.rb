Rails.application.routes.draw do
  resources :icol_validate_steps, only: [:index, :show] do
    collection do
      get :index
      put :index
    end
  end

  resources :icol_customers do
    collection do
      get :index
      put :index
    end
    member do
      get :audit_logs
      put :approve
    end
  end

  resources :icol_notifications, only: [:index, :show] do
    collection do
      get :index
      put :index
    end
    member do
      get :audit_steps
    end
  end

  resources :icol_notify_transactions
end
