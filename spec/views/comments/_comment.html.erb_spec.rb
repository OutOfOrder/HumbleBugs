require 'spec_helper'

describe "comments/_comment" do
  before(:each) do
    @commentable = FactoryGirl.create(:issue)
    @comment = FactoryGirl.create(:comment, :commentable => @commentable)
  end

  it "renders attributes in <p>" do
    render partial: 'comment', locals: { comment: @comment }

    rendered.should match(/Posted/ )
    rendered.should match(@comment.author.name)
  end
end
