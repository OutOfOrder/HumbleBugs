require 'spec_helper'

describe "releases/index" do
  before(:each) do
    @game = assign(:game, FactoryGirl.create(:game))
    assign(:releases, FactoryGirl.create_list(:release, 2, :game => @game))
  end

  it "renders a list of releases" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
#    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyString".to_s, :count => 2
  end
end
