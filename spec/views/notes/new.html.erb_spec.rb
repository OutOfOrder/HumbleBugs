require 'spec_helper'

describe "notes/new" do
  before(:each) do
    @noteable = assign(:noteable, FactoryGirl.create(:issue))
    assign(:note, FactoryGirl.build(:note, :noteable => @noteable))
  end

  it "renders new note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => polymorphic_path([@noteable, Note]), :method => "post" do
      assert_select "textarea#note_note", :name => "note[note]"
      assert_select "select#note_owner_id", :name => "note[owner_id]"
    end
  end
end
