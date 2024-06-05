class DropSystemNotificationsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :system_notifications
  end
end
