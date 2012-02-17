require 'spec_helper'

describe "ports/show" do
  before(:each) do
    @port = assign(:port, stub_model(Port,
      :game => nil,
      :porter => nil,
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/State/)
  end
end
