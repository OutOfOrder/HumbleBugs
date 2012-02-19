require 'spec_helper'

describe "releases/edit" do
  before(:each) do
    @release = assign(:release, FactoryGirl.create(:release))
    @game = assign(:game, @release.game)
  end

  it "renders the edit release form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => game_releases_path(@game, @release), :method => "post" do
      assert_select "textarea#release_notes", :name => "release[notes]"
      assert_select "select#release_owner_id", :name => "release[owner_id]"
      assert_select "input#release_url", :name => "release[url]"
    end
  end
end
