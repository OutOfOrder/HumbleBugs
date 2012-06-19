require 'spec_helper'

describe "comments/new" do
  before(:each) do
    @commentable = assign(:commentable, FactoryGirl.create(:issue))
    assign(:comment, FactoryGirl.build(:comment, :commentable => @commentable))
  end

  it "renders new comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => polymorphic_path([@commentable, Comment]), :method => "post" do
      assert_select "textarea#comment_comment", :name => "comment[comment]"
      assert_select "select#comment_author_id", :name => "comment[author_id]"
    end
  end
end
