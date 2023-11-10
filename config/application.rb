require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyBlogRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.generators do |g|
      g.test_framework nil
      g.assets false
      g.helper false
      g.stylesheets false
      g.javascripts false
    end

    config.enable_dependency_loading = true                      # use autoload_paths on production
    config.autoload_paths << Rails.root.join('lib/monkey_patch/')
    # config.autoload_paths += Dir["#{config.root}/lib", "#{config.root}/lib/**/"]
    config.autoload_paths << "#{Rails.root}/lib"

    config.time_zone = 'Asia/Ho_Chi_Minh'
    config.i18n.load_path += Dir[Rails.root.join("config",
      "locales", "**", "*.{rb,yml}").to_s]
    require 'monkey_patch/string'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
