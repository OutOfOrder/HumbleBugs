require 'spec_helper'

describe "comments/index" do
  before(:each) do
    @commentable = assign(:commentable, FactoryGirl.create(:issue))
    assign(:comments, FactoryGirl.create_list(:comment, 2, :commentable => @commentable))
  end

  it "renders a list of comments" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    #assert_select "tr>td", :text => "User".to_s, :count => 2
    #assert_select "tr>td", :text => "Issue".to_s, :count => 2
  end
end
