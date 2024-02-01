class CreateFormFields < ActiveRecord::Migration[7.0]
  def change
    create_table :form_fields, id: :uuid do |t|
      t.references :form, null: false, foreign_key: true, type: :uuid
      t.integer :field_type
      t.text :label
      t.string :font_type
      t.integer :font_size
      t.string :font_family
      t.string :fill_color
      t.string :fill_color_percent
      t.integer :alignment_type

      t.timestamps
    end
  end
end
