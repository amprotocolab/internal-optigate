module API
  module V1
    class OnesignalController < ApplicationController
      def send_notification
        onesignal_service = OneSignalService.new(
          '93cf85a7-3498-4bb6-b949-0192c66835dc',
          'ODkwMTc4MzYtM2Q2MC00ZTRiLThlODktMmMwYjkzYTYzYmYx'
        )

        title = 'Notification Title'
        content = 'Your notification message'
        headings = { en: 'Notification Title' }
        included_segments = ['All']

        onesignal_service.send_notification(title, content, headings, included_segments)

        render json: { message: 'OneSignal notification sent successfully' }
      end
    end
  end
end
