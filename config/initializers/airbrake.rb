Airbrake.configure do |config|
  if ENV['AIRBRAKE_APIKEY'].present?
    config.api_key = ENV['AIRBRAKE_APIKEY']
  end
end
