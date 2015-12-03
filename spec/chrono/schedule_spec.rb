require 'spec_helper'

describe Chrono::Schedule do
  let (:schedule) { Chrono::Schedule.new(source) }

  describe '.new' do
    subject { Chrono::Schedule.new('* * * * * *') }
    it { is_expected.to be_a(Chrono::Schedule) }
  end

  describe '#minutes' do
    subject { schedule.minutes }
    context "'0 0 * * *'" do
      let (:source){ '0 0 * * *' }
      it { is_expected.to eq [0] }
    end
    context "'59 0 * * *'" do
      let (:source){ '59 0 * * *' }
      it { is_expected.to eq [59] }
    end
    context "'60 0 * * *'" do
      let (:source){ '60 0 * * *' }
      it { expect{subject}.to raise_error(Chrono::Fields::Base::InvalidField) }
    end
  end

  describe '#hours' do
    subject { schedule.hours }
    context "'0 0 * * *'" do
      let (:source){ '0 0 * * *' }
      it { is_expected.to eq [0] }
    end
    context "'0 23 * * *'" do
      let (:source){ '0 23 * * *' }
      it { is_expected.to eq [23] }
    end
    context "'0 24 * * *'" do
      let (:source){ '0 24 * * *' }
      it { expect{subject}.to raise_error(Chrono::Fields::Base::InvalidField) }
    end
  end

  describe '#days' do
    subject { schedule.days }
    context 'day: 1' do
      let (:source){ '0 0 1 * *' }
      it { is_expected.to eq [1] }
    end
    context 'day: 31' do
      let (:source){ '0 0 31 * *' }
      it { is_expected.to eq [31] }
    end
    context 'day" 0' do
      let (:source){ '0 0 0 * *' }
      it { expect{subject}.to raise_error(Chrono::Fields::Base::InvalidField) }
    end
    context 'day: 32' do
      let (:source){ '0 0 32 * *' }
      it { expect{subject}.to raise_error(Chrono::Fields::Base::InvalidField) }
    end
  end

  describe '#months' do
    subject { schedule.months }
    context 'month: 1' do
      let (:source){ '0 0 1 1 *' }
      it { is_expected.to eq [1] }
    end
    context 'month: 12' do
      let (:source){ '0 0 1 12 0' }
      it { is_expected.to eq [12] }
    end
    context 'month: 0' do
      let (:source){ '0 0 1 0 *' }
      it { expect{subject}.to raise_error(Chrono::Fields::Base::InvalidField) }
    end
    context 'month: 13' do
      let (:source){ '0 0 13 0 *' }
      it { expect{subject}.to raise_error(Chrono::Fields::Base::InvalidField) }
    end
  end

  describe '#wdays' do
    subject { schedule.wdays }
    context 'wdays: 0' do
      let (:source){ '0 0 * * 0' }
      it { is_expected.to eq [0] }
    end
    context 'wdays: 6' do
      let (:source){ '0 0 * * 6' }
      it { is_expected.to eq [6] }
    end
    context 'wdays: 7' do
      let (:source){ '0 0 * * 7' }
      it { expect{subject}.to raise_error(Chrono::Fields::Base::InvalidField) }
    end
    context 'wdays: 8' do
      let (:source){ '0 0 * * 8' }
      it { expect{subject}.to raise_error(Chrono::Fields::Base::InvalidField) }
    end
  end
end
