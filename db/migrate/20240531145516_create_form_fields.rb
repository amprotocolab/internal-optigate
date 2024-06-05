class CreateFormFields < ActiveRecord::Migration[7.0]
  def change
    create_table :form_fields do |t|
      t.string :uuid, null: false
      t.integer :field_type, null: false
      t.text :custom_css, null: false
      t.text :label, null: false
      t.string :font_type, null: false
      t.integer :font_size, null: false
      t.string :font_family, null: false
      t.string :fill_color, null: false
      t.integer :fill_color_percent, null: false
      t.integer :alignment_type, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :form_fields, :uuid, unique: true
  end
end
