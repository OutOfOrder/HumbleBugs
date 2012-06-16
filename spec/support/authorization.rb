require 'declarative_authorization/maintenance'

include Authorization::TestHelper

RSpec.configure do |c|
  c.before :each, :type => :view do
    controller.stub(:current_user).and_return(nil)
  end
end

def render_with user, options = {}, local_assigns = {}, &block
  Authorization::Maintenance.with_user(user) do
    controller.stub(:current_user).and_return(user)
    render options, local_assigns, &block
  end
end

RSpec::Matchers.define :be_allowed_to do |privilege, skip_attributes = false|
  match do |actual|
    options = { skip_attribute_test: skip_attributes }

    actual = actual.to_sym if actual.is_a?(String)
    options[actual.is_a?(Symbol) ? :context : :object] = actual

    Authorization::Engine.instance.permit? privilege, options
  end
  failure_message_for_should do |actual|
    options = { skip_attribute_test: skip_attributes }

    actual = actual.to_sym if actual.is_a?(String)
    options[actual.is_a?(Symbol) ? :context : :object] = actual

    error = nil
    begin
      Authorization::Engine.instance.permit! privilege, options
    rescue Exception => e
      error = e
    end

    object = ':'+actual.to_s if actual.is_a?(Symbol)
    "expected #{object} to be allowed to :#{privilege}\n#{e}"
  end
  failure_message_for_should_not do |actual|
    actual = ':'+actual if actual.is_a?(Symbol) or actual.is_a?(String)
    "expected \"#{actual}\" to not be allowed to :#{privilege}"
  end
end