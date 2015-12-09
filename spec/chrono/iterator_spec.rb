require "spec_helper"

describe Chrono::Iterator do
  describe "#next" do
    [
      "2000-01-01 00:00:00", "2000-01-01 00:01:00", "* * * * *",
      "2000-01-01 00:59:00", "2000-01-01 01:00:00", "* * * * *",
      "2000-01-01 00:00:01", "2000-01-01 00:01:00", "* * * * *",
      "2000-01-01 23:59:00", "2000-01-02 00:00:00", "* * * * *",
      "2000-01-31 23:59:00", "2000-02-01 00:00:00", "* * * * *",
      "2000-12-31 23:59:00", "2001-01-01 00:00:00", "* * * * *",
      "2000-01-01 00:00:00", "2000-01-02 00:00:00", "* * 2 * *",
      "2000-01-01 00:00:00", "2000-02-01 00:00:00", "* * * 2 *",
      "2000-01-01 00:00:00", "2000-01-01 00:15:00", "*/15 * * * *",
      "2000-01-01 00:01:00", "2000-01-01 00:15:00", "*/15 * * * *",
      "2000-01-01 00:00:00", "2000-01-01 00:31:00", "*/31 * * * *",
      "2000-01-01 00:31:00", "2000-01-01 01:00:00", "*/31 * * * *",
      "2000-01-01 00:15:00", "2000-01-01 00:25:00", "*/15,25 * * * *",
      "2000-01-01 00:15:00", "2000-01-01 00:25:00", "25,*/15 * * * *",
      "2000-01-01 00:00:00", "2000-01-01 03:30:00", "30 3,6,9 * * *",
      "2000-01-01 00:00:00", "2000-01-04 00:00:00", "* * * * 2,3",
      "2000-01-04 00:00:00", "2000-01-04 00:01:00", "* * * * 2,3",
      "2000-01-01 00:01:00", "2000-01-01 00:04:00", "1-20/3 * * * *",
      "2000-01-01 00:20:00", "2000-01-01 01:01:00", "1-20/3 * * * *",
      "2000-01-01 00:00:00", "2000-01-03 00:00:00", "0 0 1,15 * 1",
      "2000-01-01 00:00:00", "2000-01-05 00:00:00", "0 0 5,15,25 * 5",
    ].each_slice(3) do |from, to, source|
      it "ticks #{from} to #{to} by #{source}" do
        now = Time.parse(from)
        expect(described_class.new(source, now: now).next).to eq(Time.parse(to))
      end

      it 'raises error when empty range is given' do
        expect { described_class.new('5-0 * * * *').next }.to raise_error(Chrono::Fields::Base::InvalidField)
      end

      it 'raises error when too large upper is given' do
        expect { described_class.new('5-60 * * * *').next }.to raise_error(Chrono::Fields::Base::InvalidField)
      end

      it 'raises error when too low lower is given' do
        expect { described_class.new('* * 0 * *').next }.to raise_error(Chrono::Fields::Base::InvalidField)
      end

      it 'raises error when unparsable field is given' do
        expect { described_class.new('a-z * * * *').next }.to raise_error(Chrono::Fields::Base::InvalidField)
      end
    end
  end
end
