require 'spec_helper'

describe "predefined_tags/new" do
  before(:each) do
    assign(:predefined_tag, FactoryGirl.build_stubbed(:predefined_tag))
  end

  it "renders new predefined_tag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => predefined_tags_path, :method => "post" do
      assert_select "input#predefined_tag_name", :name => "predefined_tag[name]"
      assert_select "select#predefined_tag_context", :name => "predefined_tag[context]"
    end
  end
end
