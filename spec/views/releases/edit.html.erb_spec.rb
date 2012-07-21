require 'spec_helper'

describe "releases/edit" do
  before(:each) do
    @release = assign(:release, FactoryGirl.create(:release))
  end

  it "renders the edit release form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => release_path(@release), :method => "post" do
      assert_select "textarea#release_notes", :name => "release[notes]"
      assert_select "input#release_version", :name => "release[version]"
      assert_select "input#release_url", :name => "release[url]"
    end
  end
end
