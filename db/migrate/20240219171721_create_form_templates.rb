class CreateFormTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :form_templates do |t|
      t.integer :form_type
      t.string :title
      t.text :custom_css
      t.jsonb :html_script
      t.integer :state
      t.boolean :prebuilt, default: false

      t.timestamps
    end
  end
end
