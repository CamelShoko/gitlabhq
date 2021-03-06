require 'spec_helper'

describe GenericCommitStatus, models: true do
  let(:pipeline) { create(:ci_pipeline) }

  let(:generic_commit_status) do
    create(:generic_commit_status, pipeline: pipeline)
  end

  describe '#context' do
    subject { generic_commit_status.context }
    before { generic_commit_status.context = 'my_context' }

    it { is_expected.to eq(generic_commit_status.name) }
  end

  describe '#tags' do
    subject { generic_commit_status.tags }

    it { is_expected.to eq([:external]) }
  end

  describe '#detailed_status' do
    let(:user) { create(:user) }

    it 'returns detailed status object' do
      expect(generic_commit_status.detailed_status(user))
        .to be_a Gitlab::Ci::Status::Success
    end
  end

  describe 'set_default_values' do
    before do
      generic_commit_status.context = nil
      generic_commit_status.stage = nil
      generic_commit_status.save
    end

    describe '#context' do
      subject { generic_commit_status.context }

      it { is_expected.not_to be_nil }
    end

    describe '#stage' do
      subject { generic_commit_status.stage }

      it { is_expected.not_to be_nil }
    end
  end
end
