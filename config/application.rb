require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EstagiosSemasc
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.time_zone = ActiveSupport::TimeZone.new('America/Recife')
    config.i18n.default_locale = :'pt-BR'
    config.exceptions_app = self.routes
    config.active_record.yaml_column_permitted_classes = [Symbol, Hash, Array, Date, DateTime, Time, BigDecimal, ActiveSupport::HashWithIndifferentAccess, ActiveSupport::TimeZone, ActiveSupport::TimeWithZone]


    config.generators do |g|
        g.orm :active_record, primary_key_type: :uuid
        g.test_framework :rspec
    end
  end
end
