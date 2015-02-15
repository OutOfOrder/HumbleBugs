require 'spec_helper'

describe "games/new" do
  let(:user) { FactoryGirl.create :user, :confirmed }
  before(:each) do
    assign(:game, FactoryGirl.build(:game))
  end

  it "renders new game form" do
    render_with user

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => games_path, :method => "post" do
      assert_select "input#game_name", :name => "game[name]"
      assert_select "textarea#game_description", :name => "game[description]"
      assert_select "select#game_bundle_id", :name => "game[bundle_id]"
      assert_select "select#game_state", :name => "game[state]"
    end
  end
end
