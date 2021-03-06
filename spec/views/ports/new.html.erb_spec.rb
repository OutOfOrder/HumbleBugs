require 'spec_helper'

describe "ports/new" do
  before(:each) do
    @port = assign(:port, FactoryGirl.build(:port))
    @game = assign(:game, @port.game)
  end

  it "renders new port form" do
    user = FactoryGirl.create :user, roles:[:user], developer: @port.developer
    render_with user

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => game_ports_path(@game), :method => "post" do
      assert_select "select#port_developer_id", :name => "port[developer_id]"
      assert_select "select#port_state", :name => "port[state]"
    end
  end
end
