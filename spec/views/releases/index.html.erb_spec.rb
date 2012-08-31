require 'spec_helper'

describe "releases/index" do
  before(:each) do
    @user = FactoryGirl.create :user, roles: [:dev]
    @game = assign(:game, FactoryGirl.create(:game))
    @releases = assign(:releases, FactoryGirl.create_list(:release, 2, :game => @game))
  end

  it "renders a list of releases" do
    render_with @user
    assert_select "tr>td", :text => @releases.first.notes, :count => 2
    assert_select "tr>td a", :text => "Download", :count => 2
    assert_select "tr>td a", :href => download_release_path(@releases.first)
    assert_select "tr>td a", :href => download_release_path(@releases.second)
  end
end
