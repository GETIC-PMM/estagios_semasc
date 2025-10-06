source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.5"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
    gem "byebug"
    gem "debug", platforms: %i[ mri mingw x64_mingw ]
    gem "web-console"
    gem "capybara"
    gem "selenium-webdriver"
    gem "webdrivers"

    # Utilidades 
    gem "letter_opener"

    # Segurança
    gem 'brakeman'

    # Teste
    gem 'rspec-rails', '~> 6.0.0'
    gem "shoulda-context"
    gem "shoulda-matchers"
    gem 'faker'
    gem "factory_bot_rails"
end


# Essencial 
gem "sidekiq"

# Configuração 
gem 'figaro'

# Utilidades
gem 'acts_as_paranoid'
gem 'audited'
gem 'exception_notification'
gem 'whenever'
gem 'cocoon'
gem 'kaminari'
gem 'array_enum'
gem 'auto_increment'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'protokoll'
gem 'seed_migration'

# Segurança
gem 'rack-attack'
gem 'cancancan'

# Use Redis for Action Cable
gem "redis", "~> 4.0"

gem "devise", "~> 4.9"
gem "enum_attributes_validation"
gem 'carrierwave', '>= 3.0.0.rc', '< 4.0'
gem "recaptcha"