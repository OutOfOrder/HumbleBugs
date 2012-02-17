require 'spec_helper'

describe "ports/edit" do
  before(:each) do
    @port = assign(:port, stub_model(Port,
      :game => nil,
      :porter => nil,
      :state => "MyString"
    ))
  end

  it "renders the edit port form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ports_path(@port), :method => "post" do
      assert_select "input#port_game", :name => "port[game]"
      assert_select "input#port_porter", :name => "port[porter]"
      assert_select "input#port_state", :name => "port[state]"
    end
  end
end
