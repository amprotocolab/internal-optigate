require 'rails_helper'

RSpec.describe Users::Searcher do
  describe '.call' do
    subject(:search_result) { described_class.call(filters) }

    let!(:user1) { create(:user, first_name: 'second') }
    let!(:user2) { create(:user, first_name: 'second first') }

    context 'when no search filters are present' do
      let(:filters) { {} }

      it { is_expected.to contain_exactly(user1, user2) }
    end

    context 'when only user name filter is present' do
      let(:filters) { { query: 'first' } }

      it { is_expected.to contain_exactly(user2) }
    end
  end
end
