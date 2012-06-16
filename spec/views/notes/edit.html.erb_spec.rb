require 'spec_helper'

describe "notes/edit" do
  before(:each) do
    @noteable = assign(:noteable, FactoryGirl.create(:issue))
    @note = assign(:note, FactoryGirl.create(:note, :noteable => @noteable))
  end

  it "renders the edit note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => polymorphic_path([@noteable, @note]), :method => "post" do
      assert_select "textarea#note_note", :name => "note[note]"
      assert_select "select#note_author_id", :name => "note[author_id]"
    end
  end
end
