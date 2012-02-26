require 'spec_helper'

describe "predefined_tags/index" do
  before(:each) do
    assign(:predefined_tags, [
      stub_model(PredefinedTag,
        :name => "Name",
        :context => "Context"
      ),
      stub_model(PredefinedTag,
        :name => "Name",
        :context => "Context"
      )
    ])
  end

  it "renders a list of predefined_tags" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Context".to_s, :count => 2
  end
end
