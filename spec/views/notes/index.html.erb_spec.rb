require 'spec_helper'

describe "notes/index" do
  before(:each) do
    @noteable = assign(:noteable, FactoryGirl.create(:issue))
    assign(:notes, FactoryGirl.create_list(:note, 2, :noteable => @noteable))
  end

  it "renders a list of notes" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    #assert_select "tr>td", :text => "User".to_s, :count => 2
    #assert_select "tr>td", :text => "Issue".to_s, :count => 2
  end
end
