require 'spec_helper'

describe "bundles/show" do
  before(:each) do
    @bundle = assign(:bundle, FactoryGirl.create(:bundle))
    @bundle.games << FactoryGirl.create(:game, :bundle => @bundle)
    assign(:games, @bundle.games)
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/planned/)
  end
end
