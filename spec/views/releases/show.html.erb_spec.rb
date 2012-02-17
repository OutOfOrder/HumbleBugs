require 'spec_helper'

describe "releases/show" do
  before(:each) do
    @release = assign(:release, stub_model(Release,
      :notes => "MyText",
      :owner => nil,
      :game => nil,
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
  end
end
