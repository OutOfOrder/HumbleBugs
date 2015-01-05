require 'spec_helper'

describe "test_results/show" do
  before(:each) do
    @test_result = assign(:test_result, FactoryGirl.create(:test_result))
  end

  it "renders attributes in <p>" do
    render

    expect(rendered).to match(/Good/)
    expect(rendered).to match(/My Comment/)
  end
end
