require 'spec_helper'

describe "games/show" do
  it "renders attributes in <p>" do
    assign(:game, FactoryGirl.create(:game))
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Pong Game/)
    expect(rendered).to match(/Prospective/)
  end

  it 'a tester can not see the bundle of a game in testing' do
    user = FactoryGirl.create :user, :roles => [:tester]
    assign(:game, FactoryGirl.create(:game, :testing))

    render_with user
    expect(rendered).to match(/Name/)
    expect(rendered).not_to match(/Bundle:/)
  end
end
