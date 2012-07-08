require 'spec_helper'

describe "games/show" do
  it "renders attributes in <p>" do
    assign(:game, FactoryGirl.create(:game))
    render
    rendered.should match(/Name/)
    rendered.should match(/Pong Game/)
    rendered.should match(/Prospective/)
  end

  it 'a tester can not see the bundle of a game in testing' do
    user = FactoryGirl.create :user, :roles => [:tester]
    assign(:game, FactoryGirl.create(:game, :testing))

    render_with user
    rendered.should match(/Name/)
    rendered.should_not match(/Bundle:/)
  end
end
