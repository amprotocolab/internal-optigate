class Form < ApplicationRecord

  belongs_to :user

  enum form_type: { modal: 0, slidein: 1, inline: 2, stickybar: 3 }

  validates :uuid, presence: true, uniqueness: true
  validates :form_type, presence: true
  validates :title, presence: true
  validates :state, presence: true

  include AASM

  aasm column: 'state' do
    state :unpublished, initial: true
    state :published
    state :archived

    event :publish do
      transitions from: :unpublished, to: :published
    end

    event :archive do
      transitions from: [:unpublished, :published], to: :archived
    end

    event :unpublish do
      transitions from: :published, to: :unpublished
    end
  end
end
