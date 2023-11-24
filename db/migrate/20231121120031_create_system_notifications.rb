class CreateSystemNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :system_notifications do |t|
      t.string :title
      t.text :content
      t.string :state, default: 'draft', null: false
      t.timestamps
    end
  end
end
