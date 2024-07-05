class SystemNotification < ApplicationRecord
  include AASM

  belongs_to :user

  validates :title, :content, presence: true
  validates :uuid, presence: true, uniqueness: true

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
