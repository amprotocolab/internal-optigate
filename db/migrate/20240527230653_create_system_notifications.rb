class CreateSystemNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :system_notifications do |t|
      t.string :uuid, null: false, default: -> { "gen_random_uuid()" }
      t.string :title, null: false
      t.text :content, null: false
      t.string :state, null: false, default: 'unread'
      t.references :user, null: false, foreign_key: true


      t.timestamps
    end

    add_index :system_notifications, :uuid, unique: true
  end
end
