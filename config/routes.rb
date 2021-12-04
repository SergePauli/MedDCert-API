Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Авторизация
  scope "REST_API/v1/auth", controller: "rest_api/v1/auth/authentication" do
    post "/registration", action: "registration"
    post "/login", action: "login"
    post "/logout", action: "logout"
    get "/activate/:link", action: "activation"
    get "/refresh", action: "refresh"
    get "/organizations", action: "get_organizations"
  end
  # Восстановление пароля
  scope "REST_API/v1/auth", controller: "rest_api/v1/auth/pass_recovery" do
    post "/renew_link", action: "renew_link"
    post "/pwd_renew", action: "pwd_renew"
  end
  # Универсальный контроллер
  scope "REST_API/v1/model/:model_name", controller: "rest_api/v1/universal_entity" do
    post "/", action: "index"
    post "/add", action: "create"
    put "/:id", action: "update"
    delete "/:id", action: "destroy"
  end
  scope "REST_API/v1/show/model/:model_name", controller: "rest_api/v1/universal_entity" do
    post "/:id", action: "show"
  end
end
