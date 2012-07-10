require File.join File.dirname(__FILE__), 'production'

HumbleBugs::Application.configure do
  config.serve_static_assets = true
end