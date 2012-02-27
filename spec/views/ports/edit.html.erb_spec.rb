require 'spec_helper'

describe "ports/edit" do
  before(:each) do
    @port = assign(:port, FactoryGirl.create(:port))
    @game = assign(:game, @port.game)
  end

  it "renders the edit port form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => game_ports_path(@game, @port), :method => "post" do
      assert_select "select#port_porter_id", :name => "port[porter_id]"
      assert_select "select#port_state", :name => "select[state]"
    end
  end
end