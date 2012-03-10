require 'spec_helper'

describe "bundles/index" do
  before(:each) do
    @bundles = assign(:bundles, FactoryGirl.create_list(:bundle, 2))
  end

  it "renders a list of bundles" do
    render
    assert_select "tr>td", :text => @bundles.first.name, :count => 2
    assert_select "tr>td", :text => @bundles.first.description, :count => 2
  end
end
