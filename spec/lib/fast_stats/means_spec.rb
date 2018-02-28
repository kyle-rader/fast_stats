require "spec_helper"

RSpec.describe FastStats::Means do

  let(:foo) { [1, 2, 2, 2, 2, 9, 9, 9, 9] }
  let(:bar) { [1, 2, 2, 2, 2, 9, 9, 9, 90] }
  let(:baz) { [0, 0, 1, 2, 2, 2, 2, 9, 9, 9, 90] }

  subject { described_class.new }

  describe '#add' do

    it { expect(subject).to respond_to :add }

    it 'requires a name and a value' do
      expect { subject.add }.to raise_error(
        ArgumentError,
        "wrong number of arguments (given 0, expected 2)"
      )
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

    let(:summary) { subject.summary round: 2 }
    let(:expected_summary) { {
      "foo" => {
        "arithmetic" => 5.0,
        "geometric" => 3.61,
      },
      "bar" => {
        "arithmetic" => 14.0,
        "geometric" => 4.67,
      },
      "baz" => {
        "arithmetic" => 11.45,
        "geometric" => 3.53,
      },
    } }

    it 'returns a summary with named means' do
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
