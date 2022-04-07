# MedDCert-API
API for my MedicalDeathCertificate's project 
## Ruby on Rails REST-API service for CRUD operations, generation print-form of Death's certificate, generation XML form according Health Level Seven Clinical Document Architecture. Release 2.0" (HL7 CDA R2.0)
_(Ruby on Rails REST-API сервис для CRUD операций с данными, генерации формы печати мед.свидетельства о смерти согласно форме №106/У от «15» апреля 2021 г, генерации электронной версии документа в XML согласно стандарту Health Level Seven Clinical Document Architecture. Release 2.0" (HL7 CDA R2.0))_
### Compatibility
  MedDCert-API tested to work with:
  * Ruby version 2.7.3 for script running
  * PostgreSQL13 as Database 
  * access-token from nsi.rosminzdrav.ru for run db initialization
  _(На стадии инициализации требуется токен для загрузки справочников с ресурса nsi.rosminzdrav.ru)_
 * requered fias-api (temporary)

### Configuration
  * config/puma.rb - defaul server ports, thread options, environment config_(можно настроить порт, режим запуска сервиса)_

  * config/initializers/cors.rb - Handle Cross-Origin Resource      Sharing (CORS) 
  >Read more: https://github.com/cyu/rack-cors

    example:

    Rails.application.config.middleware.insert_before 0, Rack::Cors do allow do
    origins "localhost:3000", "your_frontend_host:3000",

  * config/application.rd - main settings
    
  Frontend url 
    config.client_url = "http://your_frontend_host:3000"
    
  Host name and port 
    config.host = "your_backend_host:5000"
    
  Endpoint base address 
    config.base_url = "http://#{config.host}"

  Code of russia region 
    config.region = "28" _(Амурская область)_

  your userkey from NSI.minzdrav.ru 
    config.nsi_token = ENV["NSI_TOKEN"]   

  ActionMailer Config
  
  c какого адреса рассылать уведомления 
    config.from_mail = ENV["MAIL_USER"]

  SMTP server
    ActionMailer::Base.smtp_settings = {
      address: "smtp.yandex.ru",
      domain: "your_domain.ru",
      port: 465,
      user_name: config.from_mail,
      password: ENV.fetch("MAIL_PASS"),
      authentication: "plain",
      ssl: true,
    }  

  почта администратора приложения 
    
    config.admin_mail = "admin@your_domain.ru"

### Initialization    
  1. run `bin/setup`, and then, depending on the size of the input data, you will have to wait, while the database is being created from the imported files _(запускаем создание базы, и импорт данных)_
    
    $ bin/setup

  2. start server:
    
    $ rails s