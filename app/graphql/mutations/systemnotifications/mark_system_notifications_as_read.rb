module Mutations
  class MarkSystemNotificationsAsRead < BaseMutation
    argument :uuids, [ID], required: true

    field :success, Boolean, null: false

    def resolve(uuids:)
      system_notifications = SystemNotification.where(uuid: uuids)

      if system_notifications.update_all(read: true)
        { success: true }
      else
        { success: false }
      end
    end
  end
end