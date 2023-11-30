class VerificationRequest < ApplicationRecord
  belongs_to :subscriber
  belongs_to :form
end
