class SystemNotification < ApplicationRecord
  include AASM

  validates :title, :content, presence: true

  aasm column: 'state' do
    state :unread, initial: true
    state :sent
    state :read
    state :archived

    event :send_notification do
      transitions from: :draft, to: :sent
    end

    event :mark_as_read do
      transitions from: [:draft, :sent], to: :read
    end

    event :archive do
      transitions from: [:draft, :sent, :read], to: :archived
    end
  end
end
