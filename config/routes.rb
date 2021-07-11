Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Авторизация
  scope "auth", controller: "users" do
    post "/registration", action: "registration"
    post "/login", action: "login"
    post "/logout", action: "logout"
    get "/activate/:link", action: "activation"
    get "/refresh", action: "refresh"
    get "/", action: "index"
  end
end
