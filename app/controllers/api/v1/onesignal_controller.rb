module API
  module V1
    class OnesignalController < APIController
      def send_notification
        onesignal_service = OneSignalService.new(Rails.application.credentials.onesignal[:app_id],
          Rails.application.credentials.onesignal[:api_key]
        )

        title = 'Notification Title'
        content = 'Your notification message'
        headings = { en: 'Notification Title' }
        included_segments = ['All']

        onesignal_service.send_notification(title, content, headings, included_segments)

        render json: { message: 'OneSignal notification sent successfully.' }
      end
    end
  end
end
