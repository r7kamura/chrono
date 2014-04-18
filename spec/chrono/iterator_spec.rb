require "spec_helper"

describe Chrono::Iterator do
  let(:iterator) do
    described_class.new(source, now: now)
  end

  let(:source) do
    "* * * * *"
  end

  let(:now) do
    Time.local(2000, 1, 1)
  end

  describe "#next" do
    [
      "2000-01-01 00:00:00", "2000-01-01 00:01:00", "* * * * *",
      "2000-01-01 00:59:00", "2000-01-01 01:00:00", "* * * * *",
      "2000-01-01 23:59:00", "2000-01-02 00:00:00", "* * * * *",
      "2000-01-31 23:59:00", "2000-02-01 00:00:00", "* * * * *",
      "2000-12-31 23:59:00", "2001-01-01 00:00:00", "* * * * *",
      "2000-01-01 00:00:00", "2000-01-01 00:15:00", "*/15 * * * *",
      "2000-01-01 00:01:00", "2000-01-01 00:15:00", "*/15 * * * *",
      "2000-01-01 00:00:00", "2000-01-01 00:31:00", "*/31 * * * *",
      "2000-01-01 00:31:00", "2000-01-01 01:00:00", "*/31 * * * *",
    ].each_slice(3) do |from, to, source|
      it "ticks #{from} to #{to} by #{source}" do
        now = Time.parse(from)
        described_class.new(source, now: now).next.should == Time.parse(to)
      end
    end
  end
end
