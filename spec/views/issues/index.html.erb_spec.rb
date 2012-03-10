require 'spec_helper'

describe "issues/index" do
  before(:each) do
    @game = assign(:game, FactoryGirl.create(:game))
    assign(:issues, FactoryGirl.create_list(:issue, 2, :game => @game))
  end

  it "renders a list of issues" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "New".to_s, :count => 2
  end
end
