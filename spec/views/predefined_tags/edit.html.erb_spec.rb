require 'spec_helper'

describe "predefined_tags/edit" do
  before(:each) do
    @predefined_tag = assign(:predefined_tag, stub_model(PredefinedTag,
      :name => "MyString",
      :context => "MyString"
    ))
  end

  it "renders the edit predefined_tag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => predefined_tags_path(@predefined_tag), :method => "post" do
      assert_select "input#predefined_tag_name", :name => "predefined_tag[name]"
      assert_select "select#predefined_tag_context", :name => "predefined_tag[context]"
    end
  end
end
