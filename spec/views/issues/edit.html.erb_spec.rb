require 'spec_helper'

describe "issues/edit" do
  before(:each) do
    @issue = assign(:issue, FactoryGirl.create(:issue))
    @game = assign(:game, @issue.game)
  end

  it "renders the edit issue form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => game_issues_path(@game, @issue), :method => "post" do
      assert_select "textarea#issue_description", :name => "issue[description]"
      assert_select "select#issue_status", :name => "issue[status]"
    end
  end
end
