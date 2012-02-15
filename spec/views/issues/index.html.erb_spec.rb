require 'spec_helper'

describe "issues/index" do
  before(:each) do
    assign(:issues, [
      stub_model(Issue,
        :description => "MyText",
        :status => "Status"
      ),
      stub_model(Issue,
        :description => "MyText",
        :status => "Status"
      )
    ])
  end

  it "renders a list of issues" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
