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
      block.should_receive(:call)
      trigger.should_receive(:sleep)
      trigger.once
    end
  end

  # Stub Trigger#loop behavior to avoid blocking main process.
  describe "#run" do
    before do
      trigger.stub(:loop) do |&block|
        2.times do
          block.call
        end
      end
    end

    it "waits till scheduled time and then triggers a given job periodically" do
      block.should_receive(:call).twice
      trigger.should_receive(:sleep).twice
      trigger.run
    end
  end
end
