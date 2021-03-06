Rails.application.routes.draw do
  root 'home#index'

  namespace :customers do
    get "/index" , action: "index"
    get "/register" , action: "new"
    post "/" , action: "create"
    get "/personal/:id" , action: "show"
    get "/activated/:id" , action: "activated"
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

  namespace :orders do
    get "/index" , action: "index"
    get "/:id/confirm_form", action: "confirm_form"
    post "/:id/confirm", action: "confirm"
    get "/:id/payment", action: "payment"
    get "/payment/:id/success", action: "payment_success"
    get "/payment/:id/fail", action: "payment_fail"
    get "/reset", action: "reset"
  end

  namespace :employees do
    get "/index" , action: "index"
    get "/create_package_form" , action: "create_package_form"
    post "/create_package", action: "create_package"
    get "/create_optional_form" , action: "create_optional_form"
    post "/create_optional", action: "create_optional"
    get "/statistics" , action: "statistics"
  end


  get '/' => "home#index"
  get 'optional_products/index'
  get 'alerts/index'
  get 'products/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
