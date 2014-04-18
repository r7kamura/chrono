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
    ].each_slice(3) do |x, y, z|
      specify "#{x} => #{y} by #{z}" do
        described_class.new(z, now: Time.parse(x)).next.should == Time.parse(y)
      end
    end
  end
end
