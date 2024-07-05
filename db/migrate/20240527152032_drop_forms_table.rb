class DropFormsTable < ActiveRecord::Migration[7.0]
  def change
    # Drop related tables first to avoid foreign key constraint errors
    drop_table :form_fields if table_exists?(:form_fields)
    drop_table :visitors if table_exists?(:visitors)

    # Now drop the forms table
    drop_table :forms if table_exists?(:forms)
  end
end
