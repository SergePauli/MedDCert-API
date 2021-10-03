source "http://rubygems.org"
git_source(:github) { |repo| "http://github.com/#{repo}.git" }

ruby "2.7.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem "rails", "~> 6.1.3", ">= 6.1.3.2"
# Use postgresql as the database for Active Record
gem "pg"
# Use Puma as the app server
gem "puma", "~> 5.0"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Json Web Token (JWT) for token based authentication
gem "jwt"
# Use Active Model has_secure_password
gem "bcrypt", "~> 3.1.7"

#enables the creation of both simple and advanced search forms for your Ruby on Rails application
gem "ransack"
# библиотека для взаимодействия с REST-сервисами
gem "rest-client"
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# fast XML parser
#gem "nokogiri"

gem "securerandom"
# use fast import for many records
gem "activerecord-import"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  #gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
