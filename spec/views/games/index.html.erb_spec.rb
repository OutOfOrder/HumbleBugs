require 'spec_helper'

describe "games/index" do
  before(:each) do
    assign(:bundles, [])
    @games = assign(:games, FactoryGirl.create_list(:game, 2))
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", :text => @games.first.name, :count => 2
    assert_select "tr>td", :text => 'Prospective', :count => 2
  end
end
