require "spec_helper"

RSpec.describe FastStats::Mean do

  describe '#initialize' do
    subject { described_class.new }

    it 'Can be created' do
      expect(subject).to be
    end
  end

  let(:set1) { [1, 2, 2, 2, 2, 9, 9, 9, 90] }
  let(:big_numbers) { 11.times.map {|i| (i+1) * 100_000_000_000 } }

  let(:numbers_with_zeros) {
    [0, 0, 1, 2, 2, 2, 2, 9, 9, 9, 90]
  }

  describe '#add / #<<' do
    subject { described_class.new }

    it { expect(subject).to respond_to :add }

    it 'takes a value' do
      expect { subject.add 5 }.to_not raise_error
    end

    it { expect(subject).to respond_to :<< }

    it 'can be shoveled a value' do
      expect { subject << 5 }.to_not raise_error
    end

    it 'raises an error if val is < 0' do
      expect { subject << -1 }.to raise_error ArgumentError, /val must be >= 0/
      expect { subject << 0 }.to_not raise_error ArgumentError
    end
  end

  describe '#arithmetic' do
    subject { described_class.new }
    let(:values) { [] }
    before { values.each { |val| subject << val } }

    let(:mean) { subject.arithmetic round: 2 }

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
        expect(mean).to eq 11.45
      end
    end
  end

  describe '#geometric' do
    subject { described_class.new }
    let(:values) { [] }
    before { values.each { |val| subject << val } }

    let(:mean) { subject.geometric round: 2 }

    it 'return nil before values are added' do
      expect(mean).to eq nil
    end

    context 'With values' do
      let(:values) { set1 }

      it 'Has expected mean' do
        expect(mean).to eq 4.67
      end
    end

    context 'With big numbers' do
      let(:values) { big_numbers }

      it 'has expected mean' do
        expect(mean).to eq 490923877958.44
      end
    end

    context 'With zeros in the numbers' do
      let(:values) { numbers_with_zeros }

      it 'has expected mean' do
        expect(mean).to eq 3.53
      end
    end
  end

  describe '#summary' do
    subject { described_class.new }
    let(:values) { numbers_with_zeros }
    before { values.each { |val| subject << val } }
    let(:summary) { subject.summary round: 2 }

    it 'Returns a summary with named means' do
      expect(summary).to eq({
        "arithmetic" => 11.45,
        "geometric" => 3.53,
      })
    end
  end
end
