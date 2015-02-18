require 'spec_helper'

describe ApplicationHelper do
  describe "select if" do
    it 'returns selected if the passed controller name is current' do
      allow(helper).to receive(:controller_name).and_return('test_controller')
      expect(helper.select_if(:controller => :test_controller)).to eq("selected")
    end

    it 'returns nothing if the passed controller name is not current' do
      allow(helper).to receive(:controller_name).and_return('other_controller')
      expect(helper.select_if(:controller => :test_controller)).not_to eq("selected")
    end
  end

  describe 'label for' do
    let(:symbol_options) { [ ["Blue", :blue],  ["Red", :red], ] }
    let(:integer_options) { [ ['Low', 30], ['Normal', 50], ['High', 70], ] }

    context 'a symbol based option set' do
      it 'should return the label for a value' do
        expect(helper.label_for(symbol_options, 'blue')).to eq("Blue")
        expect(helper.label_for(symbol_options, 'red')).to eq("Red")
      end

      it 'should return nil if there is no matched value' do
        expect(helper.label_for(symbol_options, 'green')).to be_nil
      end
    end

    context 'integer based option set' do
      it 'should return the label for a value' do
        expect(helper.label_for(integer_options, 30)).to eq('Low')
        expect(helper.label_for(integer_options, 50)).to eq('Normal')
        expect(helper.label_for(integer_options, 70)).to eq('High')
      end

      it 'should return the previous label if it does not match exactly' do
        expect(helper.label_for(integer_options, 35)).to eq('Low')
        expect(helper.label_for(integer_options, 55)).to eq('Normal')
        expect(helper.label_for(integer_options, 75)).to eq('High')
      end

      it 'should return nil if there is no previous label' do
        expect(helper.label_for(integer_options, 25)).to be_nil
      end

      it 'should not sort the values if sorted option is passed' do
        expect(integer_options).to_not receive(:sort_by)
        helper.label_for(integer_options, 25, sorted: true)
      end
    end
  end

  describe 'platform list' do
    it 'should return a separated list of platforms' do
      @platforms = FactoryGirl.build_list :tag, 3, :name => "test"

      expect(helper.platform_list(@platforms)).to eq("test, test, test")
    end
  end
end
