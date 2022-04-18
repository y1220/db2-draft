Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  get 'optional_products/index'
  get 'alerts/index'
  get 'products/index'
  get 'product_packages/index'
  get 'orders/index'
  get 'customers/index'
  get 'employees/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
