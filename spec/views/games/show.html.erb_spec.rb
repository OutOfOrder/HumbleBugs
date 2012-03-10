require 'spec_helper'

describe "games/show" do
  before(:each) do
    @game = assign(:game, FactoryGirl.create(:game))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Name/)
    rendered.should match(/Pong Game/)
    rendered.should match(/Prospective/)
  end
end
