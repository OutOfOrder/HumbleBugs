require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ApplicationHelper do
  describe "select if" do
    it 'returns selected if the passed controller name is current' do
      helper.stub(:controller_name).and_return('test_controller')
      helper.select_if(:controller => :test_controller).should == "selected"
    end

    it 'returns nothing if the passed controller name is not current' do
      helper.stub(:controller_name).and_return('other_controller')
      helper.select_if(:controller => :test_controller).should_not == "selected"
    end
  end

  describe 'label for' do
    before do
      @options = [
          ["Blue", :blue],
          ["Red", :red],
      ]
    end
    it 'should return the label for a value' do
      helper.label_for(@options, 'blue').should == "Blue"
      helper.label_for(@options, 'red').should == "Red"
    end

    it 'should return nil if there is no matched value' do
      helper.label_for(@options, 'green').should be_nil
    end
  end

  describe 'platform list' do
    it 'should return a separated list of platforms' do
      @platforms = FactoryGirl.build_list :tag, 3, :name => "test"

      helper.platform_list(@platforms).should == "test, test, test"
    end
  end
end
