require 'spec_helper'

describe "predefined_tags/index" do
  before(:each) do
    assign(:predefined_tags, FactoryGirl.create_list(:predefined_tag, 2))
  end

  it "renders a list of predefined_tags" do
    render
    assert_select "tr>td", :text => /platform \d+/, :count => 2
    assert_select "tr>td", :text => "Platforms", :count => 2
  end
end
