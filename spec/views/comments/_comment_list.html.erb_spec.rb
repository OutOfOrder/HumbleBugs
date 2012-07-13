require 'spec_helper'

describe "comments/_comment_list" do
  it "renders a list of comments" do
    commentable = FactoryGirl.create(:issue)
    FactoryGirl.create_list(:comment, 2, :commentable => commentable)

    stub_template "comments/_comment" => "<div class=\"comment\"><%= comment.comment %></div>"
    render 'comment_list', commentable: commentable
    assert_select "input", type: 'submit', value:'New Comment'
    assert_select "div.comment", :text => "MyText", :count => 2
  end
end
