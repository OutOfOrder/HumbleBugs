require 'spec_helper'

describe "systems/index" do
  before(:each) do
    @user = assign(:user, FactoryGirl.create(:user))
    @systems = assign(:systems, FactoryGirl.create_list(:system, 2, :user => @user))
  end

  it "renders a list of systems" do
    render

    assert_select "tr>td", :text => /My System \d+/, :count => 2
    assert_select "tr>td", :text => "Minix", :count => 2
    assert_select "tr>td", :text => "M68K", :count => 2
    assert_select "tr>td", :text => "Matrox G900", :count => 2
    assert_select "tr>td", :text => "VESA", :count => 2
  end
end
