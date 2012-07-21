require 'spec_helper'

describe "test_results/new" do
  before(:each) do
    @release = assign(:release, FactoryGirl.create(:release))
    assign(:test_result, FactoryGirl.build(:test_result, release: @release))
  end

  it "renders new test_result form" do
    render

    assert_select "form", :action => release_test_results_path(@release), :method => "post" do
      assert_select "select#test_result_system_id", :name => "test_result[system_id]"
      assert_select "select#test_result_rating", :name => "test_result[rating]"
      assert_select "textarea#test_result_comments", :name => "test_result[comments]"
    end
  end
end
