# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get "clinical_document/adult/:id", controller: "rest_api/v1/clinical_document", action: "adult"
  get "clinical_document/kid/:id", controller: "rest_api/v1/clinical_document", action: "kid"

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
  # Отображение единичной записи
  scope "REST_API/v1/show/model/:model_name", controller: "rest_api/v1/universal_entity" do
    post "/:id", action: "show"
  end

  # Выдача HTML учетной формы "106/у
  scope "/REST_API/v1/print", controller: "rest_api/v1/print" do
    get "/", action: "index"
    get "/face/:id", action: "face" # лицевая сторона
    get "/back/:id", action: "back" # оборотная сторона
  end
end
