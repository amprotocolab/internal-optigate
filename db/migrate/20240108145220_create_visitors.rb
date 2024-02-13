class CreateVisitors < ActiveRecord::Migration[7.0]
  def change
    create_table :visitors, id: :uuid do |t|
      t.references :form, null: false, foreign_key: true, type: :uuid
      t.string :title
      t.string :email
      t.string :phone_number
      t.string :company
      t.string :otp_code
      t.boolean :subscriber, default: false

      t.timestamps
    end
  end
end
