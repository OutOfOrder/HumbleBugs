require 'spec_helper'

describe "issues/index" do
  before(:each) do
    @game = assign(:game, FactoryGirl.create(:game))
    @issues = assign(:issues, FactoryGirl.create_list(:issue, 2, :game => @game))
  end

  it "renders a list of issues" do
    render
    assert_select "tr>td.summary", :text => /#{@issues.first.summary}/, :count => 2
    assert_select "tr span.status", :text => @issues.first.status, :count => 2
  end
end
