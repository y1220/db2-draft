Rails.application.routes.draw do
  root 'home#index'

  namespace :customers do
    get "/index" , action: "index"
    get "/register" , action: "new"
    post "/" , action: "create"
    get "/personal/:id" , action: "show"
    get "/login_form" , action: "login_form"
    post "/login" , action: "login"
    post "/logout" , action: "logout"
  end

  namespace :products do
    get "/index" , action: "index"
  end

  get 'home/index'
  get 'optional_products/index'
  get 'alerts/index'
  get 'product_packages/index'
  get 'orders/index'
  get 'employees/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
