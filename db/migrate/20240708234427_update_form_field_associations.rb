class UpdateFormFieldAssociations < ActiveRecord::Migration[7.0]
  def change
    remove_reference :form_fields, :user, foreign_key: true
    add_reference :form_fields, :form, foreign_key: true, null: true
  end
end
