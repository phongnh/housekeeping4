Housekeeping4::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # JavaScript files you want as :defaults (application.js is always included).
  #config.action_view.javascript_expansions[:defaults] = %w(jquery jquery-ui rails)

  #config.action_view.javascript_expansions[:jquery] = %w(jquery jquery-ui rails)

  # CSS files for :960gs
  #config.action_view.stylesheet_expansions[:defaults] = %w(960gs/reset 960gs/text 960gs/960 960gs/960_24_col smoothness/jquery-ui)

  # Action Mailer
  config.action_mailer.default_url_options = { :host => 'housekeeping4.local:8000' }
end

