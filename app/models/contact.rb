class Contact < ApplicationRecord
  validates :uuid, :first_name, :last_name, :email, :contact_number, :message,  presence: true
end
