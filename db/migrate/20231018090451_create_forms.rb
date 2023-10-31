class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.string :email
      t.string :username
      t.string :title
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
