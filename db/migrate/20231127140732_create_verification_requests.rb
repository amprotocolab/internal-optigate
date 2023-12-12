class CreateVerificationRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :verification_requests do |t|
      t.boolean :verified
      t.string :otp_code

      t.timestamps
    end
  end
end
