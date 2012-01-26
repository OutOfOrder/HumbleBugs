require 'spec_helper'

describe "games/edit" do
  before(:each) do
    @game = assign(:game, stub_model(Game,
      :name => "MyString",
      :description => "MyText",
      :bundle => nil,
      :state => "MyString"
    ))
  end

  it "renders the edit game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => games_path(@game), :method => "post" do
      assert_select "input#game_name", :name => "game[name]"
      assert_select "textarea#game_description", :name => "game[description]"
      assert_select "select#game_bundle_id", :name => "game[bundle_id]"
      assert_select "input#game_state", :name => "game[state]"
    end
  end
end
