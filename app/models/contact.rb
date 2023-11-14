class Contact < ApplicationRecord
  validates :first_name, :last_name, :email, :contact_number, :message, :uid, presence: true
end
