require 'spec_helper'

describe "test_results/edit" do
  before(:each) do
    @test_result = assign(:test_result, FactoryGirl.create(:test_result))
  end

  it "renders the edit test_result form" do
    render

    assert_select "form", :action => test_result_path(@test_result), :method => "post" do
      assert_select "select#test_result_system", :name => "test_result[system]"
      assert_select "select#test_result_rating", :name => "test_result[rating]"
      assert_select "textarea#test_result_comments", :name => "test_result[comments]"
    end
  end
end
