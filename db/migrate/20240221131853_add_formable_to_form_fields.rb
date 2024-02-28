class AddFormableToFormFields < ActiveRecord::Migration[7.0]
  def change
    change_table :form_fields do |t|
      t.references :formable, polymorphic: true, index: true
    end
  end
end
