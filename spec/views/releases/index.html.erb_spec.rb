require 'spec_helper'

describe "releases/index" do
  before(:each) do
    assign(:releases, [
      stub_model(Release,
        :notes => "MyText",
        :owner => nil,
        :game => nil,
        :url => "Url"
      ),
      stub_model(Release,
        :notes => "MyText",
        :owner => nil,
        :game => nil,
        :url => "Url"
      )
    ])
  end

  it "renders a list of releases" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
