class Form < ApplicationRecord
  include AASM

  enum form_type: { modal: 0, slidein: 1, inline: 2, stickybar: 3  }
  
  has_many :form_fields, as: :formable
  has_many :visitors

  validates :form_type, :title, presence: true
  validates :custom_css, :html_script, presence: true, if: -> { form_type == 'modal' }

  # State machine 
  aasm column: 'state' do
    state :unpublished, initial: true
    state :published
    state :archived

    event :publish do
      transitions from: [:unpublished, :archived], to: :published
    end

    event :archive do
      transitions from: [:unpublished, :published], to: :archived
    end
  end

  def conversion
    return 0 if visitors.subscribers.count.zero?

    (visitors.count / visitors.subscribers.count.to_f) * 100
  end

  def visitors_who_are_subscribers
    visitors.where(subscriber: true)
  end
  
 scope :active, -> { where(state: :published) }

  def visitors_who_are_not_subscribers
    active.visitors.where(subscriber: false)
  end

end
