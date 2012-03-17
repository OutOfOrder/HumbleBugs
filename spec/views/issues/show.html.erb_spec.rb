require 'spec_helper'

describe "issues/show" do
  before(:each) do
    @issue = assign(:issue, FactoryGirl.create(:issue))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/New/)
    rendered.should match(/Issue Description/)
  end
end
