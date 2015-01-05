require 'spec_helper'

describe "issues/show" do
  before(:each) do
    @issue = assign(:issue, FactoryGirl.create(:issue))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/New/)
    expect(rendered).to match(/Issue Description/)
  end
end
