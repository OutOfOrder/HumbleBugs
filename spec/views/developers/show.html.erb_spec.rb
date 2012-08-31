require 'spec_helper'

describe "developers/show" do
  before(:each) do
    @developer = assign(:developer, FactoryGirl.create(:developer))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Dev Name \d+/)
    rendered.should match(/http:\/\/www\.gamedeveloper\.com\//)
    rendered.should match(/EST/)
    rendered.should match(/123 Nowhere/)
    rendered.should match(/555-1234/)
  end
end
