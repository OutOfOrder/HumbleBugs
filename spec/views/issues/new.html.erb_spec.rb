require 'spec_helper'

describe "issues/new" do
  before(:each) do
    assign(:issue, stub_model(Issue,
      :description => "MyText",
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new issue form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => issues_path, :method => "post" do
      assert_select "textarea#issue_description", :name => "issue[description]"
      assert_select "input#issue_status", :name => "issue[status]"
    end
  end
end
