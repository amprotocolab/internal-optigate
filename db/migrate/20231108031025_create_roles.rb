class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.uuid :uuid, null: false, default: 'uuid_generate_v4()'
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end

    add_index :roles, :uuid, unique: true
  end
end
