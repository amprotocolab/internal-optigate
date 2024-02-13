module Types
  class VisitorInput < BaseInputObject
    argument :uuid, ID, required: false
    argument :title, String, required: true
    argument :email, String, required: true
    argument :phone_number, String, required: true
    argument :company, String, required: true
    argument :otp_code, String, required: true
    argument :subscriber, Boolean, required: true
  end
end
