class CreateSystemNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :system_notifications do |t|
      t.string :title
      t.text :content
      t.boolean :read

      t.timestamps
    end
  end
end
