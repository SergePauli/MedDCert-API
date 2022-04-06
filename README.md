# MedDCert-API
API for my MedicalDeathCertificate's project 
## Ruby on Rails REST-API service for CRUD operations, generation print-form of Death's certificate, generation XML form according Health Level Seven Clinical Document Architecture. Release 2.0" (HL7 CDA R2.0)
_(Ruby on Rails REST-API сервис для CRUD операций с данными, генерации формы печати мед.свидетельства о смерти согласно форме №106/У от «15» апреля 2021 г, генерации электронной версии документа в XML согласно стандарту Health Level Seven Clinical Document Architecture. Release 2.0" (HL7 CDA R2.0))_
### Compatibility
  MedDCert-API tested to work with:
* Ruby version 2.7.3 for script running
* PostgreSQL13 as Database
_(На стадии инициализации требуется токен для загрузки справочников с ресурса nsi.rosminzdrav.ru)_
* requered fias-api (temporary)

### Configuration
* config/puma.rb - defaul server ports, thread options, environment config
_(можно настроить порт, режим запуска сервиса)_

* config/initializers/cors.rb - Handle Cross-Origin Resource Sharing (CORS)
#### Read more: https://github.com/cyu/rack-cors
example:
  Rails.application.config.middleware.insert_before 0, Rack::Cors do allow do
    origins "localhost:3000", "127.0.0.1:3000",