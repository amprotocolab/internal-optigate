class ChangeSystemNotificationStateColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :system_notifications, :read
    add_column :system_notifications, :state, :string, default: 'unread', null: false
  end
end
