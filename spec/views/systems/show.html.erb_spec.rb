require 'spec_helper'

describe "systems/show" do
  before(:each) do
    @system = assign(:system, FactoryGirl.create(:system))
    @user = assign(:user, @system.user)
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/My System \d+/)
    expect(rendered).to match(/Minix/)
    expect(rendered).to match(/M68K/)
    expect(rendered).to match(/Matrox G900/)
    expect(rendered).to match(/VESA/)
  end
end
