# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# Starting new relic manually here to support newrelic-grape
NewRelic::Agent.manual_start
NewRelic::Agent.after_fork(:force_reconnect => true)

run HumbleBugs::Application
