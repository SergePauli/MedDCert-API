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
    config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.

    config.api_only = true

    # Frontend url
    config.client_url = "http://medss.int.amurzdrav.ru"
    # Host name and port
    config.host = "localhost"
    # Endpoint base address
    config.base_url = "http://#{config.host}:5000"
    config.fias_url = "http://fias.int.amurzdrav.ru/fias"
    # code of russia region
    config.region = "28"

    # your userkey from NSI.minzdrav.ru
    config.nsi_token = ENV["NSI_TOKEN"]

    # cookies config
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    config.action_dispatch.cookies_serializer = :json

    # ActionMailer Config

    # c какого адреса рассылать уведомления
    config.from_mail = ENV["MAIL_USER"]

    #SMTP server
    ActionMailer::Base.smtp_settings = {
      address: "smtp.yandex.ru",
      domain: "amurzdrav.ru",
      port: 465,
      user_name: config.from_mail,
      password: ENV.fetch("MAIL_PASS"),
      authentication: "plain",
      ssl: true,
    }

    config.action_mailer.default_url_options = { host: config.host }
    config.action_mailer.delivery_method = :smtp
    #config.action_mailer.raise_delivery_errors = true
    # Send email in development mode.
    config.action_mailer.perform_deliveries = true

    # почта администратора приложения
    config.admin_mail = "sergepauli@yandex.ru"
  end
end
