require 'spec_helper'

describe "releases/index" do
  before(:each) do
    @game = assign(:game, FactoryGirl.create(:game))
    @releases = assign(:releases, FactoryGirl.create_list(:release, 2, :game => @game))
  end

  it "renders a list of releases" do
    render
    assert_select "tr>td", :text => @releases.first.notes, :count => 2
    assert_select "tr>td", :text => "Download", :count => 2 do
      assert_select "a", :href => @releases.first.url, :count => 2
    end
  end
end
