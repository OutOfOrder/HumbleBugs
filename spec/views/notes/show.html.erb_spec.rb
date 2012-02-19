require 'spec_helper'

describe "notes/show" do
  before(:each) do
    @noteable = FactoryGirl.create(:issue)
    @note = assign(:note, FactoryGirl.create(:note, :noteable => @noteable))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
