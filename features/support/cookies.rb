module Capybara
  class Session
    def cookies
      @cookies ||= Capybara.current_session.driver.current_session.instance_variable_get(:@rack_mock_session).cookie_jar
    end
  end
end

#Before do
#  request = ActionDispatch::Request.any_instance
#  request.stub(:cookie_jar).and_return{ page.cookies }
#  request.stub(:cookies).and_return{ page.cookies }
#end