require "spec_helper"

describe Chrono::Iterator do
  let(:iterator) do
    described_class.new(source)
  end

  let(:source) do
    "* * * * *"
  end

  describe "#next" do
    it "returns the nearest scheduled Time object from now" do
      iterator.next.should be_a Time
    end
  end
end
