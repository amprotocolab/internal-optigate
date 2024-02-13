# spec/models/visitor_spec.rb
require 'rails_helper'

RSpec.describe Visitor, type: :model do
  describe 'associations' do
    it { should belong_to(:form) }
  end

  describe 'scopes' do
    describe 'visitors_who_are_subscribers' do
      it 'returns visitors who are subscribers' do
        subscriber_visitor = create(:visitor, subscriber: true)
        non_subscriber_visitor = create(:visitor, subscriber: false)

        expect(Visitor.visitors_who_are_subscribers).to include(subscriber_visitor)
        expect(Visitor.visitors_who_are_subscribers).not_to include(non_subscriber_visitor)
      end
    end

    describe 'paying' do
      it 'returns paying visitors' do
        paying_visitor = create(:visitor, paying: true)
        non_paying_visitor = create(:visitor, paying: false)

        expect(Visitor.paying).to include(paying_visitor)
        expect(Visitor.paying).not_to include(non_paying_visitor)
      end
    end
  end

  describe '#update_paying' do
    it 'updates the visitor to paying' do
      visitor = create(:visitor, paying: false)
      visitor.update_paying
      expect(visitor.reload.paying).to eq(true)
    end
  end
end
