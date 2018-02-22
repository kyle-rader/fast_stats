require "spec_helper"

RSpec.describe FastStats::Mean do

  describe '#initialize' do
    subject { described_class.new }

    it 'requires a name:' do
      expect { subject }.to raise_error ArgumentError, /missing keyword: name/
    end
  end

  let(:set1) { [1, 2, 2, 2, 2, 9, 9, 9, 90] }
  let(:big_numbers) { 11.times.map {|i| (i+1) * 100_000_000_000 } }

  let(:numbers_with_zeros) {
    [0, 0, 1, 2, 2, 2, 2, 9, 9, 9, 90]
  }

  describe '#add / #<<' do
    subject { described_class.new name: 'foo' }

    it { expect(subject).to respond_to :add }

    it 'takes a value' do
      expect { subject.add 5 }.to_not raise_error
    end

    it { expect(subject).to respond_to :<< }

    it 'can be shoveled a value' do
      expect { subject << 5 }.to_not raise_error
    end

    it 'raises an error if val is < 0' do
      expect { subject << -1 }.to raise_error ArgumentError, /val must be > 0/
    end
  end

  describe '#arithmetic' do
    subject { described_class.new name: 'foo' }
    let(:values) { [] }
    before { values.each { |val| subject << val } }

    let(:mean) { subject.arithmetic }

    it 'returns nil before values are added' do
      expect(mean).to eq nil
    end

    context 'With values' do
      let(:values) { set1 }

      it 'Has expected mean' do
        expect(mean).to eq 14
      end
    end

    context 'With big numbers' do
      let(:values) { big_numbers }

      it 'has expected mean' do
        expect(mean).to eq 600_000_000_000.0
      end
    end

    context 'With zeros in the numbers' do
      let(:values) { numbers_with_zeros }

      it 'has expected mean' do
        expect(mean).to eq 11.454545454545455
      end
    end
  end

  describe '#geometric' do
    subject { described_class.new name: 'foo' }
    let(:values) { [] }
    before { values.each { |val| subject << val } }

    let(:mean) { subject.geometric }

    it 'return nil before values are added' do
      expect(mean).to eq nil
    end

    context 'With values' do
      let(:values) { set1 }

      it 'Has expected mean' do
        expect(mean).to eq 4.66670128104545
      end
    end

    context 'With big numbers' do
      let(:values) { big_numbers }

      it 'has expected mean' do
        expect(mean).to eq 490923877958.43896
      end
    end

    context 'With zeros in the numbers' do
      let(:values) { numbers_with_zeros }

      it 'has expected mean' do
        expect(mean).to eq 3.5267268158249334
      end
    end
  end

  describe '#summary' do
    subject { described_class.new name: 'foo' }
    let(:values) { numbers_with_zeros }
    before { values.each { |val| subject << val } }
    let(:summary) { subject.summary }

    it 'Return a summary with named means' do
      expect(summary).to eq({
        "foo_arithmetic" => 11.454545454545455,
        "foo_geometric" => 3.5267268158249334,
      })
    end
  end
end
