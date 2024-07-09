class AddEmailConfirmationWithOtpAndThankYouMessageToForms < ActiveRecord::Migration[7.0]
  def change
    add_column :forms, :email_confirmation_with_otp, :boolean, default: false, null: false
    add_column :forms, :thank_you_message, :boolean, default: false, null: false
  end
end
