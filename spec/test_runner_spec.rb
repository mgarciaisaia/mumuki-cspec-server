require_relative 'spec_helper'

describe 'running' do
  let(:runner) { TestHook.new(runcspec_command: 'runcspec') }

  describe '#run' do
    context 'on errored submission' do
      let(:file) { File.new 'spec/data/errored/compilation.c' }
      let(:result) { runner.run!(file) }

      it { expect(result[1]).to eq :errored }
      it { expect(result[0]).to include "error: expected '{' at end of input" }
    end

    context 'on failed submission' do
      let(:file) { File.new 'spec/data/failed/compilation.c' }
      let(:result) { runner.run!(file) }

      it { expect(result[1]).to eq :failed }
      it { expect(result[0]).to include 'Expected <[0mtrue[0m> but was <[0mfalse[0m>' }
    end

    context 'on passed submission' do
      let(:file) { File.new 'spec/data/passed/compilation.c' }
      let(:result) { runner.run!(file) }

      it { expect(result[1]).to eq :passed }
    end
  end
end
