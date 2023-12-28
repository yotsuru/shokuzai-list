require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShokuzaiList
  class Application < Rails::Application
    #カレンダー日本語化、日曜始まり
    config.i18n.default_locale = :ja
    config.beginning_of_week = :sunday
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Asia/Tokyo"
    # config.active_record.default_timezone = :local
    # config.eager_load_paths << Rails.root.join("extras")
    
    #レイアウト崩れ防止
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
  end
end
