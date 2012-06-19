require 'spec_helper'

describe "comments/show" do
  before(:each) do
    @commentable = FactoryGirl.create(:issue)
    @comment = assign(:comment, FactoryGirl.create(:comment, :commentable => @commentable))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
