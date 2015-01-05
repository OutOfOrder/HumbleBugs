require 'spec_helper'

describe "releases/show" do
  before(:each) do
    @release = assign(:release, FactoryGirl.create(:release))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/#{@release.url}/)
  end
end
