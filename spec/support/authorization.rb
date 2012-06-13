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