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

  namespace :product_packages do
    get "/index" , action: "index"
    post "/order_type", action: "order_type"
    get "/order_detail_form", action: "order_detail_form"
    post "/order_detail", action: "order_detail"
  end

  get 'home/index'
  get 'optional_products/index'
  get 'alerts/index'
  get 'products/index'
  get 'orders/index'
  get 'employees/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
