require 'spec_helper'

describe "test_results/index" do
  before(:each) do
    game = FactoryGirl.create :game, :testing
    @release = FactoryGirl.create :release, game: game
    @test_results = assign(:test_results, FactoryGirl.create_list(:test_result, 2, release: @release))
  end

  it "renders the edit test_result form" do
    user = FactoryGirl.create :user, roles:[:tester]
    render_with user

    assert_select "table" do
      assert_select "tr[title]", :count => 2
    end
  end

  it 'renders the page even if a system has been deleted' do
    @test_results.first.system.destroy
    @test_results.first.reload
    user = FactoryGirl.create :user, roles:[:tester]
    expect {
      render_with user
    }.to_not raise_error
  end
end
