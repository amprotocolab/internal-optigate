class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :contact_number, null: false
      t.text :message, null: false
      t.string :uid, null: false

      t.timestamps
    end
  end
end
