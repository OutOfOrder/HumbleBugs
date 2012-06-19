require 'spec_helper'

describe "comments/edit" do
  before(:each) do
    @commentable = assign(:commentable, FactoryGirl.create(:issue))
    @comment = assign(:comment, FactoryGirl.create(:comment, :commentable => @commentable))
  end

  it "renders the edit comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => polymorphic_path([@commentable, @comment]), :method => "post" do
      assert_select "textarea#comment_comment", :name => "comment[comment]"
      assert_select "select#comment_author_id", :name => "comment[author_id]"
    end
  end
end
