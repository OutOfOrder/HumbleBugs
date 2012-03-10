require 'spec_helper'

describe "predefined_tags/show" do
  before(:each) do
    @predefined_tag = assign(:predefined_tag, FactoryGirl.build_stubbed(:predefined_tag))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/My Platform/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Platforms/)
  end
end
