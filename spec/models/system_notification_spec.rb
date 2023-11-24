# spec/models/system_notification_spec.rb
require 'rails_helper'

RSpec.describe SystemNotification, type: :model do
  describe 'state transitions' do
    let(:system_notification) { create(:system_notification) }

    it 'starts in a default state' do
      expect(system_notification).to have_state(:draft)
    end

    it 'transitions to sent' do
      system_notification.send_notification
      expect(system_notification).to have_state(:sent)
    end

    it 'transitions to read' do
      system_notification.mark_as_read
      expect(system_notification).to have_state(:read)
    end

    it 'transitions to archived' do
      system_notification.archive
      expect(system_notification).to have_state(:archived)
    end
  end

  describe 'validations' do
    it 'requires title and content' do
      system_notification = build(:system_notification, title: nil, content: nil)
      expect(system_notification).not_to be_valid
      expect(system_notification.errors[:title]).to include("can't be blank")
      expect(system_notification.errors[:content]).to include("can't be blank")
    end

    #more validation tests as needed
  end
end
