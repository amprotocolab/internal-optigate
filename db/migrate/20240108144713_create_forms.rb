class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms, id: :uuid do |t|
      t.integer :form_type
      t.string :title
      t.text :custom_css
      t.jsonb :html_script
      t.integer :state

      t.timestamps
    end
  end
end
