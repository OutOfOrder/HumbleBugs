require 'spec_helper'

describe "issues/new" do
  before(:each) do
    @issue = assign(:issue, FactoryGirl.build(:issue))
    @game = assign(:game, @issue.game)
  end

  it "renders new issue form" do
    render

    assert_select "form", :action => game_issues_path(@game), :method => "post" do
      assert_select "textarea#issue_description", :name => "issue[description]"
      assert_select "select#issue_status", :name => "issue[status]"
    end
  end
end
