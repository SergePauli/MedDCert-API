require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CleanAPI
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Asia/Irkutsk"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.

    config.api_only = true

    # add autoload classes from lib/
    config.autoload_paths << Rails.root.join("lib")

    #Frontend url
    config.client_url = "http://ya.ru"

    # code of russia region
    config.region = "28"

    # put here your secret_key for JWT token
    config.jwt_access_secret = "suitable-for-API-only-apps"
    config.jwt_refresh_secret = "your-secret_key-for-JWT"

    # cookies config
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    config.action_dispatch.cookies_serializer = :json

    # ActionMailer Config
    #SMTP server
    ActionMailer::Base.smtp_settings = {
      address: "smtp.yandex.ru",
      domain: "amurzdrav.ru",
      port: 465,
      user_name: "medss@amurzdrav.ru",
      password: "hcpfupuagwmksfch",
      authentication: "plain",
      ssl: true,
    }

    config.base_url = "http://localhost:3000"

    config.action_mailer.default_url_options = { host: "localhost:3000" }
    config.action_mailer.delivery_method = :smtp
    #config.action_mailer.raise_delivery_errors = true
    # Send email in development mode.
    config.action_mailer.perform_deliveries = true
    # c какого адреса рассылать уведомления
    config.from_mail = "medss@amurzdrav.ru"
    # почта администратора приложения
    config.admin_mail = "sergepauli@yandex.ru"
  end
end
