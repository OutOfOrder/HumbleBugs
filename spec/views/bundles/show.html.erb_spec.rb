require 'spec_helper'

describe "bundles/show" do
  before(:each) do
    @bundle = assign(:bundle, FactoryGirl.create(:bundle))
    @bundle.games << FactoryGirl.create(:game, :bundle => @bundle)
    assign(:games, @bundle.games)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Planned/)
  end
end
