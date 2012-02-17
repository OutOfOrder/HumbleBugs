require 'spec_helper'

describe "notes/edit" do
  before(:each) do
    @note = assign(:note, stub_model(Note,
      :note => "MyText",
      :owner => nil,
      :noteable => nil
    ))
  end

  it "renders the edit note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notes_path(@note), :method => "post" do
      assert_select "textarea#note_note", :name => "note[note]"
      assert_select "input#note_owner", :name => "note[owner]"
      assert_select "input#note_noteable", :name => "note[noteable]"
    end
  end
end
