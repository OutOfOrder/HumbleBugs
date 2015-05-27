# config/initializers/timeout.rb
# seconds
Rack::Timeout.timeout = 20 if defined? Rack::Timeout

