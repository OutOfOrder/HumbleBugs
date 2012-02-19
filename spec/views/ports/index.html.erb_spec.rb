require 'spec_helper'

describe "ports/index" do
  before(:each) do
    @game = assign(:game, FactoryGirl.create(:game))
    assign(:ports, FactoryGirl.create_list(:port, 2, :game => @game))

  end

  it "renders a list of ports" do
    render
    #assert_select "tr>td", :text => nil.to_s, :count => 2
    #assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "planned".to_s, :count => 2
  end
end
