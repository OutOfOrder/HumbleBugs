require 'spec_helper'

describe "releases/edit" do
  before(:each) do
    @release = assign(:release, stub_model(Release,
      :notes => "MyText",
      :owner => nil,
      :game => nil,
      :url => "MyString"
    ))
  end

  it "renders the edit release form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => releases_path(@release), :method => "post" do
      assert_select "textarea#release_notes", :name => "release[notes]"
      assert_select "input#release_owner", :name => "release[owner]"
      assert_select "input#release_url", :name => "release[url]"
    end
  end
end
