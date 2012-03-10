require 'spec_helper'

describe "releases/show" do
  before(:each) do
    @release = assign(:release, FactoryGirl.create(:release))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/MyText/)
    rendered.should match(/#{@release.url}/)
  end
end
