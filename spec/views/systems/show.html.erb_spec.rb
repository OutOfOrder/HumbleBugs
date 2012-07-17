require 'spec_helper'

describe "systems/show" do
  before(:each) do
    @system = assign(:system, FactoryGirl.create(:system))
    @user = assign(:user, @system.user)
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/My System \d+/)
    rendered.should match(/Minix/)
    rendered.should match(/M68K/)
    rendered.should match(/Matrox G900/)
    rendered.should match(/VESA/)
  end
end
