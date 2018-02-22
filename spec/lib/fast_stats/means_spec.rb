require "spec_helper"

RSpec.describe FastStats::Means do

  let(:foo) { [1, 2, 2, 2, 2, 9, 9, 9, 9] }
  let(:bar) { [1, 2, 2, 2, 2, 9, 9, 9, 90] }
  let(:baz) { [0, 0, 1, 2, 2, 2, 2, 9, 9, 9, 90] }

  subject { described_class.new }

  describe '#add' do

    it { expect(subject).to respond_to :add }

    it 'requires a name and a value' do
      expect { subject.add }.to raise_error ArgumentError, "wrong number of arguments (given 0, expected 2)"
    end

    it 'can add a value for a named metric' do
      expect { subject.add 'foo', 5 }.to_not raise_error
    end
  end

  describe '#summary' do
    before do
      foo.each { |val| subject.add "foo", val }
      bar.each { |val| subject.add "bar", val }
      baz.each { |val| subject.add "baz", val }
    end

    let(:summary) { subject.summary }
    let(:expected_summary) { {
      "foo_arithmetic" => 5.0,
      "foo_geometric" => 3.6132573198349838,
      "bar_arithmetic" => 14.0,
      "bar_geometric" => 4.66670128104545,
      "baz_arithmetic" => 11.454545454545455,
      "baz_geometric" => 3.5267268158249334,
    } }

    it 'Returns a summary with named means' do
      expect(summary).to eq expected_summary
    end
  end

  context 'before adding any values' do
    let(:summary) { subject.summary }
    it 'return an empty hash' do
      expect(summary).to eq({})
    end
  end

end
