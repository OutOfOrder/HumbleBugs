require 'spec_helper'

describe "ports/show" do
  before(:each) do
    @port = assign(:port, FactoryGirl.create(:port))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Planned/)
  end
end
