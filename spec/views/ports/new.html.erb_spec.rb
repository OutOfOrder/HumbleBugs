require 'spec_helper'

describe "ports/new" do
  before(:each) do
    assign(:port, stub_model(Port,
      :game => nil,
      :porter => nil,
      :state => "MyString"
    ).as_new_record)
  end

  it "renders new port form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ports_path, :method => "post" do
      assert_select "input#port_game", :name => "port[game]"
      assert_select "input#port_porter", :name => "port[porter]"
      assert_select "input#port_state", :name => "port[state]"
    end
  end
end
