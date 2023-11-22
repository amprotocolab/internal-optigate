class SystemNotification < ApplicationRecord
  validates :title, :content, presence: true
end
