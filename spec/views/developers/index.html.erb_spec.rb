require 'spec_helper'

describe "developers/index" do
  before(:each) do
    @developers = assign(:developers, FactoryGirl.create_list(:developer, 2))
  end

  it "renders a list of developers" do
    render
    assert_select "tr>td", :text => /Dev Name \d+/, :count => 2
    assert_select "tr>td a", :text => "http://www.gamedeveloper.com/", :count => 2
    assert_select "tr>td", :text => "EST", :count => 2
  end
end
