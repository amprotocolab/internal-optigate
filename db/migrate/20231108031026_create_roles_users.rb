class CreateRolesUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :roles_users do |t|
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :role, null: false, foreign_key: { on_delete: :cascade }
    end
  end
end
