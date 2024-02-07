# spec/models/form_spec.rb
require 'rails_helper'

RSpec.describe Form, type: :model do
  describe 'associations' do
    it { should have_many(:form_fields) }
    it { should have_many(:visitors) }
  end

  describe 'validations' do
    it { should validate_presence_of(:form_type) }
    it { should validate_presence_of(:title) }

    context 'when form_type is modal' do
      subject { build(:form, form_type: :modal) }

      it { should validate_presence_of(:custom_css) }
      it { should validate_presence_of(:html_script) }
    end

    context 'when form_type is not modal' do
      subject { build(:form, form_type: :slidein) }

      it { should_not validate_presence_of(:custom_css) }
      it { should_not validate_presence_of(:html_script) }
    end
  end

  describe 'state machine' do
    let(:form) { create(:form) }

    it 'starts in the unpublished state' do
      expect(form).to have_state(:unpublished)
    end

    it 'transitions to published' do
      form.publish
      expect(form).to have_state(:published)
    end

    it 'transitions to archived' do
      form.archive
      expect(form).to have_state(:archived)
    end
  end

  describe '#conversion' do
    it 'calculates conversion rate' do
      form = create(:form)
      create(:visitor, form: form, subscriber: true)
      create(:visitor, form: form, subscriber: false)

      expect(form.conversion).to eq(50.0)
    end

    it 'returns 0 if there are no subscribers' do
      form = create(:form)
      create(:visitor, form: form, subscriber: false)

      expect(form.conversion).to eq(0)
    end
  end

  describe '#visitors_who_are_subscribers' do
    it 'returns visitors who are subscribers' do
      subscriber_visitor = create(:visitor, subscriber: true)
      non_subscriber_visitor = create(:visitor, subscriber: false)
      form = create(:form, visitors: [subscriber_visitor, non_subscriber_visitor])

      expect(form.visitors_who_are_subscribers).to include(subscriber_visitor)
      expect(form.visitors_who_are_subscribers).not_to include(non_subscriber_visitor)
    end
  end

  describe '.active' do
    it 'returns forms in published state' do
      published_form = create(:form, :published)
      unpublished_form = create(:form, :unpublished)

      expect(Form.active).to include(published_form)
      expect(Form.active).not_to include(unpublished_form)
    end
  end

  describe '#visitors_who_are_not_subscribers' do
    it 'returns visitors who are not subscribers for active forms' do
      subscriber_visitor = create(:visitor, subscriber: true)
      non_subscriber_visitor = create(:visitor, subscriber: false)
      published_form = create(:form, :published, visitors: [subscriber_visitor, non_subscriber_visitor])

      expect(published_form.visitors_who_are_not_subscribers).to include(non_subscriber_visitor)
      expect(published_form.visitors_who_are_not_subscribers).not_to include(subscriber_visitor)
    end
  end
end
