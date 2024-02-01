class Visitor < ApplicationRecord
  belongs_to :form
  scope :visitors_who_are_subscribers, -> { where(subscriber: true) }
  scope :paying, -> { where(paying: true) }

  def update_paying
    update(paying: true)
  end

end
