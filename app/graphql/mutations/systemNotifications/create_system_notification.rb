module Mutations
  module SystemNotifications
    class CreateSystemNotification < BaseMutation
      argument :title, String, required: true
      argument :content, String, required: true
      argument :state, String, required: true

      field :system_notification, Types::SystemNotificationType, null: true
      field :errors, [String], null: false

      def resolve(title:, content:, state:)
        user = context[:current_user]
        system_notification = user.system_notifications.new(title: title, content: content, state: state)

        if system_notification.save
          send_notification(title, content, state) 
          { system_notification: system_notification, errors: [] }
        else
          { system_notification: nil, errors: system_notification.errors.full_messages }
        end
      end

      private

      def send_notification(title, content, state)
        app_id = Rails.application.credentials.onesignal[:app_id]
        app_auth_key = Rails.application.credentials.onesignal[:app_auth_key]
        
        headers = {
          'Authorization' => "Basic #{app_auth_key}",
          'Content-Type' => 'application/json'
        }

        onesignal_service = Onesignalservice.new(app_id, app_auth_key)
        onesignal_service.send_notification(title, content, state, headers)
      end
    end
  end
end


