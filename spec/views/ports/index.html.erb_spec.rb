require 'spec_helper'

describe "ports/index" do
  before(:each) do
    assign(:ports, [
      stub_model(Port,
        :game => nil,
        :porter => nil,
        :state => "State"
      ),
      stub_model(Port,
        :game => nil,
        :porter => nil,
        :state => "State"
      )
    ])
  end

  it "renders a list of ports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
