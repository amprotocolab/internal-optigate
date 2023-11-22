module Mutations
  class CreateSystemNotification < BaseMutation
    argument :title, String, required: true
    argument :content, String, required: true

    field :system_notification, Types::SystemNotificationType, null: true
    field :errors, [String], null: false

    def resolve(title:, content:)
      system_notification = SystemNotification.new(title: title, content: content)

      if system_notification.save
        OneSignalService.send_notification(title, content) # Assuming you've implemented OneSignalService
        { system_notification: system_notification, errors: [] }
      else
        { system_notification: nil, errors: system_notification.errors.full_messages }
      end
    end
  end
end
