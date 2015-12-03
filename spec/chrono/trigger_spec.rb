require "spec_helper"

describe Chrono::Trigger do
  let(:trigger) do
    described_class.new(source, &block)
  end

  let(:source) do
    "* * * * *"
  end

  let(:block) do
    -> {}
  end

  describe "#once" do
    it "waits till scheduled time and then triggers a given job only once" do
      expect(block).to receive(:call)
      expect(trigger).to receive(:sleep)
      trigger.once
    end
  end

  # Stub Trigger#loop behavior to avoid blocking main process.
  describe "#run" do
    before do
      allow(trigger).to receive(:loop) do |&block|
        2.times do
          block.call
        end
      end
    end

    it "waits till scheduled time and then triggers a given job periodically" do
      expect(block).to receive(:call).twice
      expect(trigger).to receive(:sleep).twice
      trigger.run
    end
  end
end
