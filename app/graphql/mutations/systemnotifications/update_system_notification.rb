module Mutations
  class UpdateSystemNotification < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: true
    argument :content, String, required: true

    field :system_notification, Types::SystemNotificationType, null: true
    field :errors, [String], null: false

    def resolve(id:, title:, content:)
      system_notification = SystemNotification.find_by(id: id)

      if system_notification
        if system_notification.update(title: title, content: content)
          { system_notification: system_notification, errors: [] }
        else
          entity_errors(system_notification)
        end
      else
        { system_notification: nil, errors: ['System Notification not found'] }
      end
    end
  end
end
