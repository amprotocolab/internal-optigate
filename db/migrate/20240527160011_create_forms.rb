class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.string :uuid, null: false
      t.integer :form_type, null: false
      t.string :title, null: false
      t.text :html_script
      t.string :state, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :forms, :uuid, unique: true
  end
end
