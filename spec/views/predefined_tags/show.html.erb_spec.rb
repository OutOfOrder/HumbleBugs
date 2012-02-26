require 'spec_helper'

describe "predefined_tags/show" do
  before(:each) do
    @predefined_tag = assign(:predefined_tag, stub_model(PredefinedTag,
      :name => "Name",
      :context => "Context"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Context/)
  end
end
