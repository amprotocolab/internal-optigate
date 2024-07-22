class Form < ApplicationRecord

  belongs_to :user
  has_many :form_fields, dependent: :destroy
  accepts_nested_attributes_for :form_fields, allow_destroy: true

  enum form_type: { modal: 0, slidein: 1, inline: 2, stickybar: 3 }

  validates :uuid, presence: true, uniqueness: true
  validates :form_type, presence: true
  validates :title, presence: true
  validates :state, presence: true
  validates :email_confirmation_with_otp, inclusion: { in: [true, false] }
  validates :thank_you_message, inclusion: { in: [true, false] }
    
  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end  

end
