class CreateVerificationRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :verification_requests do |t|
      t.boolean :verified
      t.string :otp_code
      # t.references :subscriber, null: false, foreign_key: true
      # t.references :form, null: false, foreign_key: true

      t.timestamps
    end
  end
end
