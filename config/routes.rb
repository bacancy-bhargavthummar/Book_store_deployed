# frozen_string_literal: true

Rails.application.routes.draw do
  default_url_options host: 'bhargav.thummar@bacancytechnology.com'

  root to: 'store#index'

  resources :store do
    get 'category_filter/:id', on: :collection, action: :category_filter, as: :category_filter
  end

  resources :line_items

  resources :carts do
    get 'your_carts', on: :collection, action: :your_carts, as: :your_carts
    get 'do_approve', on: :member, action: :do_approve, as: :do_approve
    post 'do_reject', on: :member, action: :do_reject, as: :do_reject
    get 'resume_cart', on: :member, action: :resume_cart, as: :resume
  end

  devise_for :users

  resources :users, only: %i[index show] do
    get 'seller', on: :collection, action: :seller
    get 'all_pending_requests', on: :member, action: :all_pending_requests, as: :all_pending_requests
    get 'pending_requests', on: :member, action: :pending_requests, as: :pending_requests
    get 'approved_requests', on: :member, action: :approved_requests, as: :approved_requests
    get 'rejected_requests', on: :member, action: :rejected_requests, as: :rejected_requests
    get 'individual_uploads/:id', on: :collection, action: :individual_uploads, as: :individual_uploads
    delete 'destroy', action: :destroy, as: :destroy_user
  end

  resources :books do
    get 'user_uploads', on: :collection, action: :user_uploads
    resources :comments
  end

  resources :categories

  resources :charges do
    get '/order/:id' => 'charges#order_placed', as: :order
    get 'get_pdf/:id', on: :collection, action: 'get_pdf', as: :get_pdf, defaults: { format: 'pdf' }
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
