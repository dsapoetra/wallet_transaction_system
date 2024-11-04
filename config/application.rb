require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WalletTransactionSystem
  class Application < Rails::Application
    config.load_defaults 6.1
    config.api_only = true
    config.autoload_paths << Rails.root.join('lib')

    # Enable sessions for API-only mode
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: '_wallet_transaction_system_session'
  end
end
